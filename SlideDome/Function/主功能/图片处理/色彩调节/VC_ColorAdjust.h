//
//  VC_ColorAdjust.h
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "V_RollingTab.h"
#import "C_GPUImage.h"

#import "V_AdjustRGB.h"
#import "V_AdjustWhiteBalance.h"
#import "V_AdjustSaturation.h"
#import "V_AdjustContrast.h"
#import "V_AdjustBrightness.h"
#import "V_AdjustExposure.h"

#import "V_AdjustFilterEmboss.h"
#import "V_AdjustFilterSharpen.h"
#import "V_AdjustFilterBlur.h"

typedef NS_ENUM(NSInteger,PhotoEditType){
    
    //调节色彩
    PhotoEditTypeAdjustColor = 0,
    //效果
    PhotoEditTypeAdjustEffect,
    //滤镜
    PhotoEditTypeAdjustFilter

};


typedef NS_ENUM(NSInteger,adjustFilterType){

    adjustFilterTypeNormal = 0,
    //锐化
    adjustFilterTypeSharpen,
    //浮雕
    adjustFilterTypeEmboss,
    //查找边缘
    adjustFilterTypeSobelEdgeDetection,
    //模糊
    adjustFilterTypeBlur,
    //凸起
    adjustFilterTypeConvex,
    //捏变形
    adjustFilterTypePinch,
    //像素化
    adjustFilterTypePixellate,
    //拉伸
    adjustFilterTypeStretchDistortion
};


typedef NS_ENUM(NSInteger,adjustType){
    
    adjustTypeNormal = 0,
    //对比度
    adjustTypeContrast,
    //色调
    adjustTypeRGB,
    //色温
    adjustTypeWhiteBalance,
    //饱和度
    adjustTypeSaturation,
    //亮度
    adjustTypBrightnesse,
    //曝光度
    adjustTypeExposure
  
};


typedef NS_ENUM(NSInteger,imageEffectType){
    
    imageEffectTypeNormal = 0,
    //怀旧
    imageEffectTypeSepia,
    //素描
    imageEffectTypeSketch,
    //卡通
    imageEffectTypeToon,
    //晕影
    imageEffectTypeVignette,
    //水墨
    imageEffectTypeErosion,
    //上色水墨
    imageEffectTypeRGBErosion,
    //黑白照
    imageEffectTypeDilation,
    //水晶球
    imageEffectTypeSphereRefraction,
    //颜色反正
    imageEffectTypeColorInvert
    
};


@interface VC_ColorAdjust : UIViewController<V_RollingTabDelegate,AdjustRGBDelegate,AdjustContrastDelegate,AdjustWhiteBalanceDelegate,AdjustSaturationDelegate,AdjustBrightnessDelegate,AdjustExposureDelegate,AdjustFilterEmbossDeleagte,AdjustFilterSharpenDelegate,AdjustFilterBlurDelegate>

/**
 *  色彩调节
 */
@property (assign, nonatomic) adjustType adjustType;

/**
 *  效果
 */
@property (assign, nonatomic) imageEffectType imageEffectType;

/**
 *  滤镜
 */
@property (assign, nonatomic) adjustFilterType adjustFilterType;

/**
 *  图片处理类型
 */
@property (assign, nonatomic) PhotoEditType PhotoEditType;

///需要处理的图片
@property (retain, nonatomic) UIImage *image;


@property (weak, nonatomic) IBOutlet UIView *V_AdjustContent;



@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;


@end
