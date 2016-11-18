//
//  V_AdjustWhiteBalance.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustWhiteBalanceDelegate;

@interface V_AdjustWhiteBalance : UIView

@property (weak, nonatomic) id<AdjustWhiteBalanceDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Temperature;
@property (weak, nonatomic) IBOutlet UISlider *SL_Tint;


@end


@protocol AdjustWhiteBalanceDelegate <NSObject>
/**
 *  白平衡
 *
 *  @param Temperature 色温
 *  @param Tint        色彩补偿
 */
-(void)adjustWhiteBalanceWithTemperature:(NSInteger)Temperature addTint:(CGFloat)Tint;

@end