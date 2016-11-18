//
//  V_AdjustBrightness.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustBrightnessDelegate;

@interface V_AdjustBrightness : UIView

@property (weak, nonatomic) id<AdjustBrightnessDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Brigheness;

@end

@protocol AdjustBrightnessDelegate <NSObject>
/**
 *  亮度
 *
 *  @param brightness 亮度值 -1~1 normal 0.0
 */
-(void)adjustBrightness:(CGFloat)brightness;

@end