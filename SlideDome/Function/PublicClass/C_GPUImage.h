//
//  C_GPUImage.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

@interface C_GPUImage : NSObject

/**
 *  需要处理的图片
 */
@property (retain, nonatomic) UIImage *inputImage;

#pragma mark - 色彩调节 -

/**
 *  调节图片色度
 *
 *  @param R          red 0.0~1.0 正常1.0
 *  @param G          green 0.0~1.0 正常1.0
 *  @param B          blue 0.0~1.0 正常1.0
 *  @param inputImage 需要处理的图片
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustRGB:(CGFloat)R addG:(CGFloat)G addB:(CGFloat)B;

/**
 *  对比度
 *
 *  @param contrast   对比度 0.0~4.0 默认1
 *  @param inputImage 需要处理的图片
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustContrast:(CGFloat)contrast;

/**
 *  色温调节
 *
 *  @param temperature 色温
 *  @param tint        色彩补偿
 *  @param inputImage  需要处理的图片
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustWhiteBalanceWithTemperature:(CGFloat)temperature addTint:(CGFloat)tint;

/**
 *  饱和度调节
 *
 *  @param saturation 饱和度 0.0~2.0 正常1
 *  @param inputImage 需要处理的图片
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustSaturationWithSaturation:(CGFloat)saturation;

/**
 *  亮度调节
 *
 *  @param brightness 亮度 -1~1 正常 0.0
 *  @param inputImage 需要处理的图片
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustBrightness:(CGFloat)brightness;

/**
 *  曝光度调节
 *
 *  @param exposure   曝光度 -10.0~10.0 正常 0.0
 *  @param inputImage 需要处理的图片
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustExposure:(CGFloat)exposure;

#pragma mark - 效果 -

/**
 *  效果
 *
 *  @param effect     GPUImage里的滤镜类名
 *  @param inputImage 需要处理的图片
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageImageEffectWithEffect:(NSString *)effect;


#pragma mark - 滤镜 -

/**
 *  浮雕
 *
 *  @param intensity 强度 0.0 ~ 4.0 normal 1.0
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustFilterEmboss:(CGFloat)intensity;

/**
 *  锐化
 *
 *  @param sharpen 锐化值 -4.0 ~ 4.0 normal 0.0
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustFilterSharpen:(CGFloat)sharpen;

/**
 *  模糊
 *
 *  @param blurRadiusInPixels 模糊程度吧 0~10
 *
 *  @return 处理后的图片
 */
-(UIImage *)GPUImageAdjustFilterBlur:(CGFloat)blurRadiusInPixels;



-(UIImage *)GPUImageAdjustFilterBlur:(CGFloat)blurRadiusInPixels addPoint:(CGPoint)point;










@end
