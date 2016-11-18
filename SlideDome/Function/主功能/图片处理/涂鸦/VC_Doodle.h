//
//  VC_Doodle.h
//  SlideDome
//
//  Created by ceing on 16/11/18.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "V_DrawingBoard.h"

@interface VC_Doodle : UIViewController

/**
 *  需要处理的图片
 */
@property (retain, nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;
@property (weak, nonatomic) IBOutlet UIButton *BTN_Eraser;
@property (weak, nonatomic) IBOutlet UIButton *BTN_Pen;

@end
