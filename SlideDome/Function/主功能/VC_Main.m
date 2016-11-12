//
//  VC_Main.m
//  SlideDome
//
//  Created by ceing on 16/11/8.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_Main.h"

@interface VC_Main (){

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

@implementation VC_Main

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [self initData];
    
    
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self collectionView:self.CV_PhotoList didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    PHAsset *sset = _arrayPhotos[0];
    [[PHCachingImageManager defaultManager] requestImageForAsset:sset targetSize:_IV_Image.frame.size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        _IV_Image.image = result;
        
    }];
}
-(void)viewWillLayoutSubviews{

    if(self.automaticallyAdjustsScrollViewInsets == YES){
    
        [self initView];
        
    }

    
}

-(void)initView{
    
    self.title = @"制作视频";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.CV_PhotoList.delegate = self;
    self.CV_PhotoList.dataSource = self;
    self.CV_PhotoList.alwaysBounceHorizontal = YES;
    [self.CV_PhotoList registerNib:[UINib nibWithNibName:@"CellPhotoPreview" bundle:nil] forCellWithReuseIdentifier:CellPreviewID];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback
             withOptions:AVAudioSessionCategoryOptionMixWithOthers
                   error:nil];
    
    V_RollingTab *rollingTab = [[V_RollingTab alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.IV_Image.frame), MainBoundsSize.width, 35)];
    rollingTab.delegate = self;
    rollingTab.arrayTitles = arrayEffect;
    rollingTab.isCanRoll = YES;
    rollingTab.isAddIndexLine = YES;
    rollingTab.tabTitleSize = CGSizeMake(80, 35);
    [self.view addSubview:rollingTab];
    
}



-(void)initData{
    
    option = [[PHImageRequestOptions alloc] init];
    option.synchronous = YES;
    option.resizeMode = PHImageRequestOptionsResizeModeNone;
    //@"浮雕效果" @"素描" @"收缩失真"
    arrayEffect = @[@"默认",@"怀旧",@"素描",@"模糊",@"腐烂效果",@"素描",@"鱼眼",@"收缩失真",@"伸展失真",@"水晶球效果",@"水晶球倒影效果",@"浮雕效果"];
    arrayFiler = @[@"GPUImageSharpenFilter",@"GPUImageSepiaFilter",@"GPUImageSketchFilter",@"GPUImageGaussianBlurFilter",@"GPUImageErosionFilter",@"GPUImageThresholdSketchFilter",@"GPUImageBulgeDistortionFilter",@"GPUImagePinchDistortionFilter",@"GPUImageStretchDistortionFilter",@"GPUImageGlassSphereFilter",@"GPUImageSphereRefractionFilter",@"GPUImageEmbossFilter"];
                   
//                   @{@"naem":@"GPUImageSepiaFilter",@"title":@"怀旧"},
//                   @{@"name":@"GPUImageSketchFilter",@"title":@"素描"},
//                   @{@"name":@"GPUImageSharpenFilter",@"title":@"锐化"},
//                   @{@"name":@"GPUImageColorPackingFilter",@"title":@"X光照"},
//                   @{@"name":@"GPUImageGaussianBlurFilter",@"title":@"高斯模糊"},
//                   @{@"name":@"GPUImageErosionFilter",@"title":@"腐烂效果"},
//                   @{@"name":@"GPUImageThresholdSketchFilter",@"title":@"素描"},
//                   @{@"name":@"GPUImageTiltShiftFilter",@"title":@"条纹模糊"},
//                   @{@"name":@"GPUImageBulgeDistortionFilter",@"title":@"中间凸起"},
//                   @{@"name":@"GPUImageToonFilter",@"title":@"卡通效果"},
//                   @{@"name":@"GPUImageSmoothToonFilter",@"title":@"1"},
//                   @{@"name":@"GPUImagePosterizeFilter",@"title":@"色调分离"},
//                   @{@"name":@"GPUImageCrosshatchFilter",@"title":@"网格"},
//                   @{@"name":@"GPUImagePixellateFilter",@"title":@"马赛克"},
//                   @{@"name":@"GPUImageVignetteFilter",@"title":@"黑色阴影"},
//                   @{@"name":@"GPUImagePinchDistortionFilter",@"title":@"收缩失真，拉远"},
//                   @{@"name":@"GPUImageStretchDistortionFilter",@"title":@"伸展失真"},
//                   @{@"name":@"GPUImageGlassSphereFilter",@"title":@"水晶球效果"},
//                   @{@"name":@"GPUImageSphereRefractionFilter",@"title":@"圆倒立"},
//                   @{@"name":@"GPUImagePerlinNoiseFilter",@"title":@"1"},
//                   @{@"name":@"GPUImageEmbossFilter",@"title":@"浮雕效果"}
//                   ];
//
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
        
        _IV_Image.image = result;
        
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
               
            if(viewContent == nil){
            
                viewContent = [[UIView alloc] initWithFrame:self.view.bounds];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(videoStop)];
                [viewContent addGestureRecognizer:tap];
                
                
                item = [AVPlayerItem playerItemWithURL:savePath];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];

                player = [AVPlayer playerWithPlayerItem:item];
                player.volume = 0.5;
                playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
                playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                
                playerLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
                playerLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                [viewContent.layer addSublayer:playerLayer];
                
//                
//                Btn_Replay = [UIButton buttonWithType:UIButtonTypeCustom];
//                Btn_Replay.hidden = YES;
//                Btn_Replay.frame = CGRectMake(0, 0, 80, 80);
//                Btn_Replay.center = viewContent.center;
//                [Btn_Replay setTitle:@"重播" forState:0];
//                [Btn_Replay addTarget:self action:@selector(BTN_Play:) forControlEvents:UIControlEventTouchUpInside];
//                [viewContent addSubview:Btn_Replay];
            }
            
            [player play];
            [weakSelf.view addSubview:viewContent];
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
