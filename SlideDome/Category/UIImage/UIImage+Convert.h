//
//  UIImage+Convert.h
//  ImageToVideoDemo
//
//  Created by 陈东芝 on 16/11/6.
//  Copyright © 2016年 myqiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Convert)


+(UIImage *)imageMergeWithImages:(NSArray *)images;

+(UIImage *)imageClipWithImage:(UIImage *)image;

+(NSArray *)imageChangeAlphaWithImage:(UIImage *)image;
+(NSArray *)imageChangeLargerWithImage:(UIImage *)image;


/**
 图片合成 上下重叠

 @param image1 底图
 @param image2 上层图
 @return 合成图片
 */
+(UIImage *)imageMergeWithImage1:(UIImage *)image1 addImage2:(UIImage *)image2;
@end
