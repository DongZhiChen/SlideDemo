//
//  UIImage+WaterMark.m
//  DXS
//
//  Created by ceing on 16/8/11.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "UIImage+WaterMark.h"

@implementation UIImage (WaterMark)

#pragma mark - 添加logo水印 -

///frame .y 反过来
-(UIImage *)imageAddWaterMarkImage:(UIImage *)wartMark WithWaterMarkRect:(CGRect)frame{
    
    //get image width and height
    
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    ///原来图片
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    
    ///水印图片
    CGContextDrawImage(context, frame, wartMark.CGImage);
   
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *newImage = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return newImage;
    
}



#pragma mark - 添加文字水印 -

-(UIImage *)imageAddWaterMarkTitle:(NSString *)title addWaterMarkRect:(CGRect)frame{
    
    return [self imageAddWaterMarkTitle:title addTitleColor:[UIColor blackColor] addTitleFont:[UIFont systemFontOfSize:14] WithWaterMarkRect:frame];
}


-(UIImage *)imageAddWaterMarkTitle:(NSString *)title addTitleColor:(UIColor *)color addTitleFont:(UIFont *)font WithWaterMarkRect:(CGRect)frame{
    
    // 开启图形'上下文'
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 绘制原生图片
    [self drawAtPoint:CGPointZero];
    // 在原生图上绘制文字
    NSString *str = title;
    // 创建文字属性字典
    NSDictionary *dictionary = @{NSForegroundColorAttributeName: color, NSFontAttributeName: font};
    // 绘制文字属性
    [str drawInRect:frame withAttributes:dictionary];
    // 从当前上下文获取修改后的图片
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return imageNew;
}


#pragma mark - 截取View图片 -

+ (UIImage *)imageCutOutScreenWithSize:(CGSize) size addScreenView:(UIView *)screenView{
    
    UIGraphicsBeginImageContext(size);
    
    [screenView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image,self, nil, nil);
    return image;
}


@end
