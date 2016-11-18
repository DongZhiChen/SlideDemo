//
//  V_AdjustFilterBlur.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustFilterBlurDelegate;

@interface V_AdjustFilterBlur : UIView

@property (weak, nonatomic) id<AdjustFilterBlurDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Blur;

@end


@protocol AdjustFilterBlurDelegate <NSObject>

/**
 *  高斯模糊
 *
 *  @param blurRadiusInPixels 模糊程度
 */
-(void)adjustFilterBlur:(CGFloat)blurRadiusInPixels;

@end