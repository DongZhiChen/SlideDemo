//
//  VC_EditPhoto.h
//  SlideDome
//
//  Created by ceing on 16/11/17.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "V_RollingTab.h"
#import "VC_ColorAdjust.h"
#import "VC_Doodle.h"


@interface VC_EditPhoto : UIViewController <V_RollingTabDelegate>

/**
 *  需要处理的图片
 */
@property (retain, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;

@end
