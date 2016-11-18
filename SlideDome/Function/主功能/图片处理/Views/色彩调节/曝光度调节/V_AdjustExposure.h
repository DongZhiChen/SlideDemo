//
//  V_AdjustExposure.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustExposureDelegate;

@interface V_AdjustExposure : UIView

@property (weak, nonatomic) id<AdjustExposureDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Exposure;

@end


@protocol AdjustExposureDelegate <NSObject>
/**
 *  曝光度
 *
 *  @param exposure 曝光程度 -10.0 ~ 10.0 normal 0.0
 */
-(void)adjustExposure:(CGFloat)exposure;

@end