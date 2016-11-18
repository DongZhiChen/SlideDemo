//
//  V_AdjustFilterEmboss.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdjustFilterEmbossDeleagte;

@interface V_AdjustFilterEmboss : UIView

@property (weak, nonatomic) id<AdjustFilterEmbossDeleagte> delegate;

@property (weak, nonatomic) IBOutlet UISlider *SL_Emboss;

@end

@protocol AdjustFilterEmbossDeleagte <NSObject>

/**
 *  浮雕
 *
 *  @param intensity 强度
 */
-(void)adjustFilterEmboss:(CGFloat)intensity;

@end

