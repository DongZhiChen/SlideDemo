//
//  UIImage+WaterMark.h
//  DXS
//
//  Created by ceing on 16/8/11.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WaterMark)


#pragma mark - 添加logo水印 -

-(UIImage *)imageAddWaterMarkImage:(UIImage *)wartMark WithWaterMarkRect:(CGRect)frame;


#pragma mark - 添加文字水印 -

-(UIImage *)imageAddWaterMarkTitle:(NSString *)title addWaterMarkRect:(CGRect)frame;

-(UIImage *)imageAddWaterMarkTitle:(NSString *)title addTitleColor:(UIColor *)color addTitleFont:(UIFont *)font WithWaterMarkRect:(CGRect)frame;

#pragma mark - 屏幕截取 -

+ (UIImage *)imageCutOutScreenWithSize:(CGSize) size addScreenView:(UIView *)screenView;



@end


