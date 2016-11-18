//
//  VideoBuilder.m
//  ConvertVideo
//
//  Created by myqiqiang on 15/11/17.
//  Copyright © 2015年 myqiqiang. All rights reserved.
//

#import "VideoBuilder.h"


@interface VideoBuilder ()

@property AVAssetWriter *videoWriter;
@property AVAssetWriterInputPixelBufferAdaptor *adaptor;
@property AVAssetWriterInput *writerInput;

@property NSInteger frameNumber;

@property CGSize    videoSize;
@property NSString *videoPath;
@property int32_t timeScale;

@property BOOL maskFinishResult;
@property BOOL saveToPhotosGalleryResult;

@end

@implementation VideoBuilder

- (VideoBuilder *)initWithOutputSize:(CGSize )size Timescale:(int32_t )scale OutputPath:(NSString *)path{
    self = [super init];
    
    if (self) {
        
        _videoSize = size;
        _videoPath = path;
        _timeScale = scale;
        
        NSError *error = nil;
        
        self.videoWriter = [[AVAssetWriter alloc]initWithURL:[NSURL fileURLWithPath:path]
                                                    fileType:AVFileTypeMPEG4
                                                       error:&error];
        
        NSParameterAssert(self.videoWriter);
        
        NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                       AVVideoCodecH264,AVVideoCodecKey,
                                       [NSNumber numberWithInt:_videoSize.width],AVVideoWidthKey,
                                       [NSNumber numberWithInt:_videoSize.height],AVVideoHeightKey,
                                       nil];
        
        self.writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo
                                                              outputSettings:videoSettings];
        
        self.adaptor = [AVAssetWriterInputPixelBufferAdaptor
                        assetWriterInputPixelBufferAdaptorWithAssetWriterInput:self.writerInput
                        sourcePixelBufferAttributes:nil];
        
        NSParameterAssert(self.writerInput);
        NSParameterAssert([self.videoWriter canAddInput:self.writerInput]);
        
        [self.videoWriter addInput:self.writerInput];
        
        [self.videoWriter startWriting];
        
        [self.videoWriter startSessionAtSourceTime:kCMTimeZero];
    }
    
    return self;
}

/**
 *
 *
 *  @param image
 *  @param finish
 */
/**
 *  通过图片添加视频帧
 *
 *  @param image  图片
 *
 *  @return 是否添加成功
 */
- (BOOL)addVideoFrameWithImage:(UIImage *)image{
    
    CVPixelBufferRef buffer = NULL;
    
    if (self.writerInput.readyForMoreMediaData) {
        CMTime frameTime = CMTimeMake(0, self.timeScale);
        
        CMTime lastTime = CMTimeMake(self.frameNumber, self.timeScale);
        
        CMTime presentTime = CMTimeAdd(lastTime, frameTime);
        
        if (self.frameNumber == 0) {
            presentTime = CMTimeMake(0, self.timeScale);
        }
        
        buffer = [self pixelBufferFromCGImage:[image CGImage]];
        if (buffer) {
            
            if ([self.adaptor appendPixelBuffer:buffer withPresentationTime:presentTime]) {
                CVPixelBufferRelease(buffer);
                self.frameNumber += 2;
                return YES;
            }
            
        }
        
    }
    
    return NO;
    
}

- (void)maskFinishWithSuccess:(successBlock)success Fail:(failBlock)fail {
    
    [self.writerInput markAsFinished];
    
    [self.videoWriter finishWritingWithCompletionHandler:^{
        if (self.videoWriter.status != AVAssetReaderStatusFailed && self.videoWriter.status == AVAssetWriterStatusCompleted) {
            
            if (success) {
                success();
            }
            
        } else {
            if (fail) {
                fail(_videoWriter.error);
            }
            
            NSLog(@"create video failed, %@",self.videoWriter.error);
        }
    }];
    
    CVPixelBufferPoolRelease(self.adaptor.pixelBufferPool);
}
/**
 *  用图片数组一次性生成视频
 *
 *  @param images 图片数组
 */
- (void)convertVideoWithImageArray:(NSArray *)images {
    
    int i;
    CVPixelBufferRef buffer = NULL;
    
    for ( i = 0; i < [images count];) {
        if (self.writerInput.readyForMoreMediaData) {
            CMTime frameTime = CMTimeMake(0,self.timeScale);
            
            CMTime lastTime = CMTimeMake(i*2,self.timeScale);
            
            CMTime presentTime = CMTimeAdd(lastTime, frameTime);
            
//            if (i == 0) {
//                presentTime = CMTimeMake(0,self.timeScale);
//            }
            
            buffer = [self pixelBufferFromCGImage:[images[i] CGImage]];
            
            if ( buffer ) {
                
                if ([self.adaptor appendPixelBuffer:buffer withPresentationTime:presentTime]) {
                    i++;
                }
            
                CVPixelBufferRelease(buffer);
            }
        }
    }
    
//    if (i == images.count) {
//        
//        [self maskFinishWithSuccess:^{
//            //[self saveToPhotosGalleryWithVideoPath:[NSURL URLWithString:_videoPath] toastResultInView:nil];
//        } Fail:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
//    }
}

- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image {
    
    if (image) {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES],kCVPixelBufferCGImageCompatibilityKey,
                                 [NSNumber numberWithBool:YES],kCVPixelBufferCGBitmapContextCompatibilityKey, nil];
        
        CVPixelBufferRef pxbuffer = NULL;
        
        // TODO:kCVPixelFormatType_32ARGB 可改
        CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, CGImageGetWidth(image), CGImageGetHeight(image), kCVPixelFormatType_32ARGB,(__bridge CFDictionaryRef)options, &pxbuffer);
        
        NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
        //
        CVPixelBufferLockBaseAddress(pxbuffer, 0);
        void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
        NSParameterAssert(pxdata != NULL);
        
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGContextRef context = CGBitmapContextCreate(pxdata, CGImageGetWidth(image), CGImageGetHeight(image), 8, 4*CGImageGetWidth(image), rgbColorSpace, kCGImageAlphaNoneSkipFirst);
        //
        NSParameterAssert(context);
        //
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
        CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
        
        CGColorSpaceRelease(rgbColorSpace);
        CGContextRelease(context);
        
        CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
        
        return pxbuffer;
    } else {
        return NULL;
    }
    
    
}


/**
 video 添加音乐

 @param audioPath 音乐路径
 */
- (void)addAudioToVideoAudioPath:(NSString *)audioPath addSaveVideoBlock:(void(^)(NSURL *))saveVideoBlock{
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:audioPath] options:nil];
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:self.videoPath] options:nil];
    
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    AVAssetExportSession* assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetPassthrough];
    
    NSString *exportPath = self.videoPath;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:exportPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
    }
    
    NSURL *exportUrl = [NSURL fileURLWithPath:exportPath];
    
    assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    assetExport.outputURL = exportUrl;
    assetExport.shouldOptimizeForNetworkUse = YES;
    [assetExport exportAsynchronouslyWithCompletionHandler:^(){
        saveVideoBlock(exportUrl);
    }];
    
}



@end
