//
//  VC_MakeVideo.m
//  SlideDome
//
//  Created by ceing on 16/11/8.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_MakeVideo.h"

@interface VC_MakeVideo (){

    PHImageRequestOptions *option;
   ;
    
    AVPlayerLayer *playerLayer;
    AVPlayerItem *item;
    AVPlayer *player;
    UIView *viewContent;
    UIButton *Btn_Replay;
    
    NSArray *arrayEffect;
    NSArray *arrayFiler;
    
    
}

@property VideoBuilder *videoBuilder;
@property NSString *videoPath;
@property NSTimer *timer;
@property (nonatomic,retain) UIImageView *IV_Border;
@end
static NSString *CellPreviewID = @"CellPhotoPreview";

@implementation VC_MakeVideo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    [self initView];
    
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self collectionView:self.CV_PhotoList didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    PHAsset *sset = _arrayPhotos[0];
    [[PHCachingImageManager defaultManager] requestImageForAsset:sset targetSize:_IV_Image.frame.size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        _IV_Image.image = result;
        
    }];
    
}



-(void)initView{
    
    self.title = @"Make Video";
  
    self.CV_PhotoList.delegate = self;
    self.CV_PhotoList.dataSource = self;
    self.CV_PhotoList.alwaysBounceHorizontal = YES;
    [self.CV_PhotoList registerNib:[UINib nibWithNibName:@"CellPhotoPreview" bundle:nil] forCellWithReuseIdentifier:CellPreviewID];
    
}


-(void)initData{
    
    option = [[PHImageRequestOptions alloc] init];
    option.synchronous = YES;
    option.resizeMode = PHImageRequestOptionsResizeModeNone;
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseMuisc:) name:@"chooseMuisc" object:nil];
    

}


-(void)chooseMuisc:(NSNotification *)notiy{

    _strMusicPath = notiy.object;
    
}


-(void)lookImageWithFilerName:(NSString *)filerName{
    
    UIImage *inputImage = self.IV_Image.image;
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    id stillImageFilter = [[NSClassFromString(filerName) alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *imageOut = [stillImageFilter imageFromCurrentFramebuffer];
    
    self.IV_Image.image = imageOut;
}



#pragma mark - V_RollingTabDelegate -

-(void)V_RollingTabSelectedIndx:(NSInteger)index{
    
    [self lookImageWithFilerName:arrayFiler[index]];
    
}


#pragma mark - UICollectionViewDataSource -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrayPhotos.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CellPhotoPreview *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellPreviewID forIndexPath:indexPath];
    
    PHAsset *phasset = self.arrayPhotos[indexPath.row];
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:phasset targetSize:CGSizeZero contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        
        cell.IV_Photo.image = image;
        
    }];
    
    
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PHAsset *sset = _arrayPhotos[indexPath.row];
    [[PHCachingImageManager defaultManager] requestImageForAsset:sset targetSize:_IV_Image.frame.size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
       // _IV_Image.image = result;
        
        VC_EditPhoto *editPhoto = [[VC_EditPhoto alloc] init];
        editPhoto.image = result;
        [self.navigationController pushViewController:editPhoto animated:YES];
        
    }];

    CellPhotoPreview *cell = (CellPhotoPreview *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell addSubview:self.IV_Border];
    
}



#pragma mark - UICollectionViewDelegateFlowLayout -

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(50, 50);
    
}

-(void)makeVideo{
    
    NSString *fileNameOut2 = @"output.mp4";
    _videoPath = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fileNameOut2];
    NSLog(@"%@",_videoPath);
    [[NSFileManager defaultManager] removeItemAtPath:_videoPath  error:NULL];
    
    _videoBuilder = [[VideoBuilder alloc]initWithOutputSize:CGSizeMake(640, 360) Timescale:1 OutputPath:_videoPath];
    
    NSMutableArray *arrayImages = [NSMutableArray new];
    
    for(int i = 0; i < _arrayPhotos.count; i++){
        
        PHAsset *asset = _arrayPhotos[i];
        
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(640, 360) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            
            [arrayImages addObject:image];
            
        }];
    }

    [_videoBuilder convertVideoWithImageArray:arrayImages];
    [_videoBuilder maskFinishWithSuccess:^{
        
        [_videoBuilder addAudioToVideoAudioPath:_strMusicPath addSaveVideoBlock:^(NSURL *savePath){}];
        
    } Fail:^(NSError *error) {
    
        
    }];
    
}


#pragma mark -

- (IBAction)BTN_Muisc:(id)sender {
    
    VC_MuiscList *muiscList = [[VC_MuiscList alloc] init];
    [self.navigationController pushViewController:muiscList animated:YES];
    
}

-(void)videoStop{

    [player pause];
    
    [playerLayer removeFromSuperlayer];
    playerLayer = nil;

    player = nil;
    item = nil;
    
    [viewContent removeFromSuperview];
    viewContent = nil;
   
    
}


- (IBAction)BTN_Play:(UIButton *)sender {
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  
    __weak typeof(self) weakSelf = self;
    
    NSString *fileNameOut2 = @"output.mp4";
    _videoPath = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fileNameOut2];
    NSLog(@"%@",_videoPath);
    [[NSFileManager defaultManager] removeItemAtPath:_videoPath  error:NULL];
    
    _videoBuilder = [[VideoBuilder alloc]initWithOutputSize:CGSizeMake(640, 360) Timescale:1 OutputPath:_videoPath];
    
    NSMutableArray *arrayImages = [NSMutableArray new];
    
    for(int i = 0; i < _arrayPhotos.count; i++){
        
        PHAsset *asset = _arrayPhotos[i];
        
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:VedioSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            
            [arrayImages addObject:[UIImage imageClipWithImage:image]];
            
        }];
    }
    
    [_videoBuilder convertVideoWithImageArray:arrayImages];
    [_videoBuilder maskFinishWithSuccess:^{
        
        [_videoBuilder addAudioToVideoAudioPath:_strMusicPath addSaveVideoBlock:^(NSURL *savePath){
        
           dispatch_async(dispatch_get_main_queue(), ^{
               
               [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

               VC_VideoPlayer *palyer = [[VC_VideoPlayer alloc] init];
               palyer.videoPath = savePath;
               [weakSelf.navigationController pushViewController:palyer animated:YES];

               });
        }];
        
    } Fail:^(NSError *error) {
        
    }];
    
}

- (IBAction)BTN_Back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)itemDidFinishPlaying:(NSNotification *)notiy{

    [self videoStop];
    Btn_Replay.hidden = NO;
    
    
}


- (IBAction)BTN_Preview:(id)sender {
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self) weakSelf = self;
    
    NSString *fileNameOut2 = @"output.mp4";
    _videoPath = [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fileNameOut2];
    NSLog(@"%@",_videoPath);
    [[NSFileManager defaultManager] removeItemAtPath:_videoPath  error:NULL];
    
    _videoBuilder = [[VideoBuilder alloc]initWithOutputSize:CGSizeMake(640, 360) Timescale:1 OutputPath:_videoPath];
    
    NSMutableArray *arrayImages = [NSMutableArray new];
    
    for(int i = 0; i < _arrayPhotos.count; i++){
        
        PHAsset *asset = _arrayPhotos[i];
        
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:VedioSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            
            [arrayImages addObject:[UIImage imageClipWithImage:image]];

            
        }];
    }
    
    [_videoBuilder convertVideoWithImageArray:arrayImages];
    [_videoBuilder maskFinishWithSuccess:^{
        
        [_videoBuilder addAudioToVideoAudioPath:_strMusicPath addSaveVideoBlock:^(NSURL *savePath){
            
           
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    
                    [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL fileURLWithPath:_videoPath]];
                    
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    
                    if(success){
                        dispatch_async(dispatch_get_main_queue(), ^{
                        
                            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

                            
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Video files have been deposited in the album" preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *action = [UIAlertAction actionWithTitle:@"I Know" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
                            
                            [alert addAction:action];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        
                        });
                       
                    }
                    
                }];
            
        }];
        
    } Fail:^(NSError *error) {
        
    }];
    
    
    }



#pragma mark - setter,getter -

-(UIImageView *)IV_Border{
    
    if( !_IV_Border ){
        
        _IV_Border = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _IV_Border.layer.borderWidth = 2.0;
        _IV_Border.layer.borderColor = [UIColor colorWithRed:0 green:122.0/255 blue:1 alpha:1].CGColor;
        
    }
    
    return _IV_Border;
    
}


-(void)setArrayPhotos:(NSArray *)arrayPhotos{

    _arrayPhotos = arrayPhotos;
    
}


#pragma mark - 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
