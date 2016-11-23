//
//  V_DrawingBoard.h
//  DoodleDemo
//
//  Created by ceing on 16/11/16.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DrawingType){

    //画线（开始涂鸦）
    DrawingTypeDrawLine = 0,
    //橡皮擦
    DrawingTypeEraser,
    //清除全部
    DrawingTypeClearAll
    
};

@interface V_DrawingBoard : UIView

/**
 *  涂鸦类型
 */
@property (assign, nonatomic) DrawingType DrawingType;


/**
 * 涂鸦层 的图片
 */
@property (retain, readonly, nonatomic) UIImage *imageDoodle;

@end
