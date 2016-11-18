//
//  V_AdjustSaturation.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustSaturationDelegate;

@interface V_AdjustSaturation : UIView

@property (weak, nonatomic) id<AdjustSaturationDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Saturation;

@end

@protocol AdjustSaturationDelegate <NSObject>
/**
 *  饱和度
 *
 *  @param saturation 饱和度值 0.0 ~ 2.0 normal 1.0
 */
-(void)adjustSaturation:(CGFloat)saturation;

@end