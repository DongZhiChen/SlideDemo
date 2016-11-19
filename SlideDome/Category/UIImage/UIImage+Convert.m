//
//  UIImage+Convert.m
//  ImageToVideoDemo
//
//  Created by 陈东芝 on 16/11/6.
//  Copyright © 2016年 myqiqiang. All rights reserved.
//

#import "UIImage+Convert.h"

@implementation UIImage (Convert)

+(UIImage *)imageMergeWithImages:(NSArray *)images{

     UIGraphicsBeginImageContext(VedioSize);
    
    for(int i = 0; i < images.count; i++){
    
        NSDictionary *dict = images[i];
        UIImage *image = dict[@"image"];
        CGRect frame = [dict[@"frame"] CGRectValue];

        [image drawInRect:frame];
        
    }
    
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;

}




+(NSArray *)imageChangeLargerWithImage:(UIImage *)image{

    NSMutableArray *array = [NSMutableArray new];
    
    UIGraphicsBeginImageContext(VedioSize);
    
    for(int i = 0; i < 40; i++){
        
        float w = VedioSize.width/40.0*i;
        float h = VedioSize.height/40.0*i;
        float x = VedioSize.width/2.0-w/2.0;
        float y = VedioSize.height/2.0-h/2.0;
        
        CGRect frame = CGRectMake(x, y, w, h);
        
        [image drawInRect:frame];
        UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
        
        [array addObject:resultingImage];
    }
    
    
    
    UIGraphicsEndImageContext();
    
    return array;
    
}
+(UIImage *)imageClipWithImage:(UIImage *)image{

    
    UIGraphicsBeginImageContext(VedioSize);
    
    [image drawInRect:CGRectMake(0, 0, VedioSize.width, VedioSize.height)];
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;

    
}


+(NSArray *)imageChangeAlphaWithImage:(UIImage *)image{
    
//    UIGraphicsBeginImageContext(VedioSize);
//    [image drawInRect:CGRectMake(0, 0, VedioSize.width, VedioSize.height)];
//    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
    
    NSMutableArray *array = [NSMutableArray new];
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    
    for(int i = 0; i <= 40; i++){
    
        CGContextSetAlpha(ctx, i/40.0);
        NSLog(@"%f",i/40.0);
        CGContextDrawImage(ctx, area, image.CGImage);
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        [array addObject:newImage];
        
    }
   
    UIGraphicsEndImageContext();
    
    return array;
    
}


+(UIImage *)imageMergeWithImage1:(UIImage *)image1 addImage2:(UIImage *)image2{

    UIGraphicsBeginImageContext(image1.size);
    
    CGRect frame = CGRectMake(0, 0, image1.size.width, image1.size.height);
    [image1 drawInRect:frame];
    [image2 drawInRect:frame];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return resultImage;
}

@end
