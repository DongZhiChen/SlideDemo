//
//  VC_Main.h
//  SlideDome
//
//  Created by ceing on 16/11/8.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellPhotoPreview.h"
#import <Photos/PHAsset.h>
#import <Photos/PHFetchOptions.h>
#import <Photos/PHCollection.h>
#import <Photos/PHImageManager.h>
#import "VC_MuiscList.h"
#import "VideoBuilder.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIImage+Convert.h"

#import "V_RollingTab.h"
#import <GPUImage/GPUImage.h>

@interface VC_Main : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,V_RollingTabDelegate>

@property (nonatomic,retain) NSString *strMusicPath;

@property (weak, nonatomic) IBOutlet UICollectionView *CV_PhotoList;

@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;

- (IBAction)BTN_Preview:(id)sender;
@property (nonatomic,retain)  NSArray *arrayPhotos;
- (IBAction)BTN_Muisc:(id)sender;
- (IBAction)BTN_Play:(UIButton *)sender;
- (IBAction)BTN_Back:(id)sender;

@end
