//
//  DZSliderChooseColor.h
//  DZSlider
//
//  Created by 陈东芝 on 16/11/15.
//  Copyright © 2016年 陈东芝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZSliderChooseColor : UIControl

@property (assign, nonatomic) CGFloat value;

@property (assign, nonatomic) CGFloat maxValue;

@property (assign, nonatomic) CGFloat minVlaue;

@property (retain, nonatomic) UIColor *startColor;

@property (retain, nonatomic) UIColor *endColor;

@end
