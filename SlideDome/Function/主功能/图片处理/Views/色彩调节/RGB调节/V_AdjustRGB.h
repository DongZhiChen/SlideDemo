//
//  V_AdjustRGB.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZSliderChooseColor.h"

@protocol AdjustRGBDelegate;

@interface V_AdjustRGB : UIView

@property (assign, nonatomic) id<AdjustRGBDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_R;
@property (weak, nonatomic) IBOutlet UISlider *SL_G;
@property (weak, nonatomic) IBOutlet UISlider *SL_B;

@property (weak, nonatomic) IBOutlet DZSliderChooseColor *DZSL_R;
@property (weak, nonatomic) IBOutlet DZSliderChooseColor *DZSL_G;
@property (weak, nonatomic) IBOutlet DZSliderChooseColor *DZSL_B;

@end


@protocol AdjustRGBDelegate <NSObject>

/**
 *  RGB色调
 *
 *  @param R red  0.0 ~ 1.0 normal 1.0
 *  @param G green 0.0 ~ 1.0 normal 1.0
 *  @param B blue 0.0 ~ 1.0 normal 1.0
 */
-(void)adjustRGBWithR:(CGFloat)R addG:(CGFloat)G addB:(CGFloat)B;

@end

