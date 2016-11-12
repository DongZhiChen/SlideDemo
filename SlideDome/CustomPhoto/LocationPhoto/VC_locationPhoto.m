//
//  VC_locationPhoto.m
//  Com.message
//
//  Created by lee on 24/3/2015.
//  Copyright (c) 2015年 sanchuan. All rights reserved.
//

#import "VC_locationPhoto.h"

@interface VC_locationPhoto (){

    NSMutableArray *arrayPHAsset;
    ///图片是否被选状态
    NSMutableArray *arrayImageState;
    
}
@property VideoBuilder *videoBuilder;
@property NSString *videoPath;
@property NSTimer *timer;

@end

static NSString *cellID = @"CellLocationPhoto";

@implementation VC_locationPhoto

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    self.CV_photoList.delegate=self;
    self.CV_photoList.dataSource=self;
    
    [self.CV_photoList registerNib:[UINib nibWithNibName:@"CellLocationPhoto" bundle:nil] forCellWithReuseIdentifier:cellID];
    
}

-(void)initData{
    
    arrayImageState = [NSMutableArray new];

    for(int i = 0; i < arrayPHAsset.count; i++){
    
        [arrayImageState addObject:@0];
        
    }
    
    
}
#pragma mark - UICollectionViewDataSource -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return arrayPHAsset.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    CellLocationPhoto *cell=[collectionView dequeueReusableCellWithReuseIdentifier: cellID forIndexPath:indexPath];
    
    int state = [arrayImageState[indexPath.row] intValue];
    
    if(state == 0){
    
        cell.IV_State.image = nil;
        
    }else{
    
        cell.IV_State.image = [UIImage imageNamed:@"Check"];
        
    }
    
    PHAsset *phasset = arrayPHAsset[indexPath.row];
   
    [[PHCachingImageManager defaultManager] requestImageForAsset:phasset targetSize:CGSizeMake(150, 150) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        
        cell.img_BG.image = image;
        
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate -

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    int state = [arrayImageState[indexPath.row] intValue];
    
    state = state == 0 ? 1:0;
    
    [arrayImageState replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:state]];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout -

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((MainBoundsSize.width-40)/3.0, (MainBoundsSize.width-40)/3.0);
    
}


#pragma mark - setter,getter -

-(void)setImageGroup:(PHAssetCollection *)imageGroup{
    
    arrayPHAsset = [NSMutableArray new];
    
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:imageGroup options:nil];
    for(PHAsset *phasset in result){
        
        [arrayPHAsset addObject:phasset];
        
    }
}


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


static int count = 0;
- (void)addImage {
    
    if (count < 3) {
        
        NSString *name = [NSString stringWithFormat:@"IMG_%d.jpg",count];
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
        
        if(image) {
            
            UIImage *clipImage = [UIImage imageClipWithImage:image];
            NSData *clipCompressData = UIImageJPEGRepresentation(clipImage, 0.0f);
            UIImage *clipCompressImage = [UIImage imageWithData:clipCompressData];
            
            if ([_videoBuilder addVideoFrameWithImage:clipCompressImage]) {
                count ++;
            }
        }
        
    } else {
        
        [_timer invalidate];
        [_videoBuilder maskFinishWithSuccess:^{
            
            //[_videoBuilder addAudioToVideoAudioPath:[[NSBundle mainBundle] pathForResource:@"audio" ofType:@"mp3"]];
            
        } Fail:^(NSError *error) {
        }];
        
    }
    
}


- (IBAction)BTN_OK:(id)sender {
    
    NSMutableArray *arrayImages = [NSMutableArray new];
    
    for(int i = 0; i < arrayImageState.count; i++){
        
        int state = [arrayImageState[i] intValue];
        
        if(state == 1){
            
            PHAsset *asset = arrayPHAsset[i];
            [arrayImages addObject:asset];
            
        }
    }

    
    if(arrayImages.count > 0){
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"observerSelectedPhoto" object:arrayImages];
    }
    
    [self dismissToRootController];
    
}

@end
