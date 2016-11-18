//
//  V_AdjustContrast.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustContrastDelegate;

@interface V_AdjustContrast : UIView

@property (weak, nonatomic) id<AdjustContrastDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Contrast;

@end

@protocol AdjustContrastDelegate <NSObject>
/**
 *  对比度
 *
 *  @param contrast 对比度值 0.0 ~ 4.0 normal 1.0
 */
-(void)adjustContrast:(CGFloat)contrast;

@end