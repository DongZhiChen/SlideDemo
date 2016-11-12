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
@end
