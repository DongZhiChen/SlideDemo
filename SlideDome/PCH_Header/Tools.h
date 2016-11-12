//
//  Config.h
//  DXS
//
//  Created by ceing on 16/5/20.
//  Copyright © 2016年 tcm. All rights reserved.
//

#ifndef Config_h
#define Config_h


#endif /* Config_h */


#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define MainBoundsSize [UIScreen mainScreen].bounds.size

///角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

///四舍五入保留两位小数
#define RoundfNumber2Point(Number) roundf(Number*100)/100

///Document路径
#define DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]


#define VedioSize CGSizeMake(640, 360)


