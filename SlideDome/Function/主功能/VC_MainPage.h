//
//  VC_MainPage.h
//  SlideDome
//
//  Created by ceing on 16/11/4.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VC_PhotoGroup.h"
#import "CellPhotoPreview.h"
#import "VC_MuiscList.h"
#import "VC_MakeVideo.h"

typedef NS_ENUM(NSInteger,muiscType) {

    muiscTypeHappy,
    muiscTypeSad,
    muiscTypeQuiet,
    muiscTypeCafard
    
};

@interface VC_MainPage : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
- (IBAction)BTN_Muisc:(id)sender;

- (IBAction)BTN_Preview:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BTN_ChoosePhoto;
@property (weak, nonatomic) IBOutlet UICollectionView *CV_PhotoList;
- (IBAction)BTN_Type:(UIButton *)sender;

@end
