//
//  V_AdjustFilterSharpen.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustFilterSharpenDelegate;

@interface V_AdjustFilterSharpen : UIView

@property (weak, nonatomic) id<AdjustFilterSharpenDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Sharpness;

@end

@protocol AdjustFilterSharpenDelegate <NSObject>

/**
 *  锐化
 *
 *  @param sharpen 锐度
 */
-(void)adjustFilterSharpen:(CGFloat)sharpen;

@end