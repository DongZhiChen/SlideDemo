//
//  C_GPUImage.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "C_GPUImage.h"


@implementation C_GPUImage

#pragma mark - 色彩调节 -

-(UIImage *)GPUImageAdjustRGB:(CGFloat)R addG:(CGFloat)G addB:(CGFloat)B{
    
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    GPUImageRGBFilter *stillImageFilter = [[GPUImageRGBFilter alloc] init];
    stillImageFilter.red = R;
    stillImageFilter.green = G;
    stillImageFilter.blue = B;
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;
    
}



-(UIImage *)GPUImageAdjustContrast:(CGFloat)contrast{

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    GPUImageContrastFilter *stillImageFilter = [[GPUImageContrastFilter alloc] init];
    stillImageFilter.contrast = contrast;
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;
    
}

-(UIImage *)GPUImageAdjustWhiteBalanceWithTemperature:(CGFloat)temperature addTint:(CGFloat)tint{

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageWhiteBalanceFilter *stillImageFilter = [[GPUImageWhiteBalanceFilter alloc] init];
    stillImageFilter.temperature = temperature;
    stillImageFilter.tint = tint;
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;

    
}

-(UIImage *)GPUImageAdjustSaturationWithSaturation:(CGFloat)saturation{
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageSaturationFilter *stillImageFilter = [[GPUImageSaturationFilter alloc] init];
    stillImageFilter.saturation = saturation;

    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;
    
}


-(UIImage *)GPUImageAdjustBrightness:(CGFloat)brightness{

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageBrightnessFilter *stillImageFilter = [[GPUImageBrightnessFilter alloc] init];
    stillImageFilter.brightness = brightness;
    
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;

}


-(UIImage *)GPUImageAdjustExposure:(CGFloat)exposure{

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageExposureFilter *stillImageFilter = [[GPUImageExposureFilter alloc] init];
    stillImageFilter.exposure = exposure;
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;
    
}
#pragma mark - 效果 -


-(UIImage *)GPUImageImageEffectWithEffect:(NSString *)effect{

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageFilter *stillImageFilter = [[NSClassFromString(effect) alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;
    
}


#pragma mark - 滤镜 -

-(UIImage *)GPUImageAdjustFilterEmboss:(CGFloat)intensity{

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageEmbossFilter *stillImageFilter = [[GPUImageEmbossFilter alloc] init];
    stillImageFilter.intensity = intensity;
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;

}



-(UIImage *)GPUImageAdjustFilterSharpen:(CGFloat)sharpen{

    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageSharpenFilter *stillImageFilter = [[GPUImageSharpenFilter alloc] init];
    stillImageFilter.sharpness = sharpen;
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;

}


-(UIImage *)GPUImageAdjustFilterBlur:(CGFloat)blurRadiusInPixels{
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageGaussianBlurFilter *stillImageFilter = [[GPUImageGaussianBlurFilter alloc] init];
    stillImageFilter.blurRadiusInPixels = blurRadiusInPixels;
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
    
    return currentFilteredVideoFrame;
    
}



-(UIImage *)GPUImageAdjustFilterBlur:(CGFloat)blurRadiusInPixels addPoint:(CGPoint)point{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageGaussianBlurPositionFilter *stillImageFilter = [[GPUImageGaussianBlurPositionFilter alloc] init];
    stillImageFilter.blurCenter = point;
    stillImageFilter.blurSize = 0.1;
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
    
    return currentFilteredVideoFrame;
}






@end
