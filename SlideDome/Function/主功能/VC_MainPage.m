//
//  VC_MainPage.m
//  SlideDome
//
//  Created by ceing on 16/11/4.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_MainPage.h"

@interface VC_MainPage (){

    NSMutableArray *arrayPhotos;
    NSString *muiscPath;
    
}
@property VideoBuilder *videoBuilder;
@property NSString *videoPath;
@property NSTimer *timer;
@property (nonatomic,assign) muiscType muiscType;

@end

static NSString *CellPreviewID = @"CellPhotoPreview";

@implementation VC_MainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  [self.BTN_ChoosePhoto bk_addEventHandler:^(id sender) {
      
      [self choosePhoto];
      
  } forControlEvents:UIControlEventTouchUpInside];
    
    
    [self initData];
    [self initView];

}



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
}


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark  - initSet -

-(void)initView{
    
    self.CV_PhotoList.delegate = self;
    self.CV_PhotoList.dataSource = self;
    self.CV_PhotoList.alwaysBounceHorizontal = YES;
    [self.CV_PhotoList registerNib:[UINib nibWithNibName:@"CellPhotoPreview" bundle:nil] forCellWithReuseIdentifier:CellPreviewID];
    
//    
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.alpha = 0.8;
//    effectView.frame = [UIScreen mainScreen].bounds;
//    [self.view insertSubview:effectView atIndex:1];
    
}


-(void)initData{

    arrayPhotos = [NSMutableArray new];
    self.muiscType = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerSelectedPhoto:) name:@"observerSelectedPhoto" object:nil];
    
}

#pragma mark - notification -

-(void)observerSelectedPhoto:(NSNotification *)notiy{

   // [arrayPhotos removeAllObjects];
//    [arrayPhotos addObjectsFromArray:notiy.object];
//    
//    if(arrayPhotos.count > 0){
//        
//        self.CV_PhotoList.hidden = NO;
//        
//    }else{
//    
//        self.CV_PhotoList.hidden = YES;
//    }
//    
//    [self.CV_PhotoList reloadData];
    
    VC_MakeVideo *main  = [[VC_MakeVideo alloc] init];
    main.arrayPhotos = notiy.object;
    main.strMusicPath = muiscPath;
    [self.navigationController pushViewController:main animated:YES];
    
}


#pragma mark - UICollectionViewDataSource -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrayPhotos.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

   CellPhotoPreview *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellPreviewID forIndexPath:indexPath];

    
    PHAsset *phasset = arrayPhotos[indexPath.row];
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:phasset targetSize:CGSizeZero contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        
        cell.IV_Photo.image = image;
        
    }];

    
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}



#pragma mark - UICollectionViewDelegateFlowLayout -

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(50, 50);
    
}




#pragma mark - UIButtonEventClick -

- (IBAction)BTN_Type:(UIButton *)sender {
    
    if(self.BTN_ChoosePhoto.hidden){
    
        self.BTN_ChoosePhoto.hidden = NO;
    }
    
    UIButton *lastBTN = [self.view viewWithTag:_muiscType+100];
    lastBTN.selected = NO;
    
    NSInteger index = sender.tag -100;
    self.muiscType = index;
    sender.selected = YES;
    
}




- (IBAction)BTN_Muisc:(id)sender {
    
    VC_MuiscList *muiscList = [[VC_MuiscList alloc] init];
    [self.navigationController pushViewController:muiscList animated:YES];
    
}

- (IBAction)BTN_Preview:(id)sender {
    
    
}


-(void)choosePhoto{

    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Please set permission to access album" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Not allow" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            dispatch_after(0.2, dispatch_get_main_queue(), ^{
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            });
            
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else if(status == PHAuthorizationStatusNotDetermined){
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if(status == PHAuthorizationStatusAuthorized){
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    VC_PhotoGroup *photoGroup = [[VC_PhotoGroup alloc] init];
                    [self.navigationController pushViewController:photoGroup animated:YES];
                    
                });
                
                
            }
            
        }];
        
    }else if(status == PHAuthorizationStatusAuthorized){
        
        VC_PhotoGroup *photoGroup = [[VC_PhotoGroup alloc] init];
        [self.navigationController pushViewController:photoGroup animated:YES];
    }
    
}

#pragma mark - setter,getter -

-(void)setMuiscType:(muiscType)muiscType{
    
    _muiscType = muiscType;
    switch (muiscType) {
        case muiscTypeHappy:{
            
            muiscPath = [[NSBundle mainBundle] pathForResource:@"欢快" ofType:@"mp3"];
            
        }break;
        case muiscTypeSad:{
            
            muiscPath = [[NSBundle mainBundle] pathForResource:@"悲伤" ofType:@"mp3"];
            
        }break;
        case muiscTypeQuiet:{
            
            muiscPath = [[NSBundle mainBundle] pathForResource:@"平静" ofType:@"mp3"];
            
        }break;
        case muiscTypeCafard:{
            
            muiscPath = [[NSBundle mainBundle] pathForResource:@"忧郁" ofType:@"mp3"];
            
        }break;
        default:
            break;
    }
}



#pragma mark - 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
