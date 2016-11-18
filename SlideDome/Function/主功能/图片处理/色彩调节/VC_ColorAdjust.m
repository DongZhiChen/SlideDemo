//
//  VC_ColorAdjust.m
//  SlideDome
//
//  Created by ceing on 16/11/15.
//  Copyright © 2016年 tcm. All rights reserved.
//

#import "VC_ColorAdjust.h"

@interface VC_ColorAdjust (){

    NSArray *arrayEffect;
    
    V_AdjustRGB *adjustRGB;
    V_AdjustWhiteBalance *adjustWhiteBalance;
    V_AdjustSaturation *adjustSaturation;
    V_AdjustContrast *adjustContrast;
    V_AdjustBrightness *adjustBrightness;
    V_AdjustExposure *adjustExposure;
    
    V_AdjustFilterEmboss *adjustFilterEmboss;
    V_AdjustFilterSharpen *adjustFilterSharpen;
    V_AdjustFilterBlur *adjustFilterBlur;
    
    
    
}

@property (retain, nonatomic) UIImage *resultImage;

@end

@implementation VC_ColorAdjust

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initData];
    [self initView];
    self.resultImage = self.image;
    
}


-(void)initView{

    self.title = @"色彩调节";
    
    self.IV_Image.image = self.image;
    
    V_RollingTab *rollingTab = [[V_RollingTab alloc] initWithFrame:CGRectMake(0, MainBoundsSize.height - 35, MainBoundsSize.width, 35)];
    rollingTab.delegate = self;
    rollingTab.arrayTitles = arrayEffect;
    rollingTab.isCanRoll = YES;
    rollingTab.isAddIndexLine = YES;
    rollingTab.tabTitleSize = CGSizeMake(80, 35);
    [self.view addSubview:rollingTab];

}


-(void)initData{

}



#pragma mark - 色彩调节 delegate -

-(void)adjustExposure:(CGFloat)exposure{

    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
   self.IV_Image.image = [GPUImage GPUImageAdjustExposure:exposure];
    
}

-(void)adjustBrightness:(CGFloat)brightness{

    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
    self.IV_Image.image = [GPUImage GPUImageAdjustBrightness:brightness];
    
}

-(void)adjustSaturation:(CGFloat)saturation{

    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage  = _resultImage;
    self.IV_Image.image = [GPUImage GPUImageAdjustSaturationWithSaturation:saturation];
}

-(void)adjustWhiteBalanceWithTemperature:(NSInteger)Temperature addTint:(CGFloat)Tint{
    
    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
   self.IV_Image.image = [GPUImage GPUImageAdjustWhiteBalanceWithTemperature:Temperature addTint:Tint];
    

}
-(void)adjustContrast:(CGFloat)contrast{
    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
    self.IV_Image.image = [GPUImage GPUImageAdjustContrast:contrast];

}


-(void)adjustRGBWithR:(CGFloat)R addG:(CGFloat)G addB:(CGFloat)B{

    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
    self.IV_Image.image = [GPUImage GPUImageAdjustRGB:R addG:G addB:B];

}


#pragma mark - 滤镜调节delegate -

-(void)adjustFilterEmboss:(CGFloat)intensity{

    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
    self.IV_Image.image = [GPUImage GPUImageAdjustFilterEmboss:intensity];

}

-(void)adjustFilterSharpen:(CGFloat)sharpen{

    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
    self.IV_Image.image = [GPUImage GPUImageAdjustFilterSharpen:sharpen];

}

-(void)adjustFilterBlur:(CGFloat)blurRadiusInPixels{

    C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
    GPUImage.inputImage = _resultImage;
    self.IV_Image.image = [GPUImage GPUImageAdjustFilterBlur:blurRadiusInPixels];
    
}



#pragma mark - V_RollingTabDelegate -

-(void)V_RollingTabSelectedIndx:(NSInteger)index{

    _resultImage = self.IV_Image.image;
    
    switch (self.PhotoEditType) {
        case PhotoEditTypeAdjustColor:{
        
            self.adjustType = index;
            
        }break;
        case PhotoEditTypeAdjustEffect:{
            
            self.imageEffectType = index;
            
        }break;
        case PhotoEditTypeAdjustFilter:{
            
            self.adjustFilterType = index;
            
        }break;
        default:
            break;
    }
}


#pragma mark - setter,getter -

-(void)setAdjustFilterType:(adjustFilterType)adjustFilterType{
    
    _adjustFilterType = adjustFilterType;
    
    [self.V_AdjustContent.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.V_AdjustContent.bounds)-50, MainBoundsSize.width, 50);
    
    switch (adjustFilterType) {
        case adjustFilterTypeNormal:{
        
             self.IV_Image.image = self.image;
            
        }break;
            
        case adjustFilterTypeSharpen:{
            
            if(adjustFilterSharpen == nil){
                
                adjustFilterSharpen = [[V_AdjustFilterSharpen alloc] initWithFrame:frame];
                adjustFilterSharpen.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustFilterSharpen];
            
        }break;
        case adjustFilterTypeEmboss:{
            
            if(adjustFilterEmboss == nil){
                
                adjustFilterEmboss = [[V_AdjustFilterEmboss alloc] initWithFrame:frame];
                adjustFilterEmboss.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustFilterEmboss];
            
        }break;
        case adjustFilterTypeSobelEdgeDetection:{
        
            C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
            GPUImage.inputImage = self.image;
            self.IV_Image.image = [GPUImage GPUImageImageEffectWithEffect:@"GPUImageSobelEdgeDetectionFilter"];
            
        }break;
        case adjustFilterTypeBlur:{
        
            if(adjustFilterBlur == nil){
                
                adjustFilterBlur = [[V_AdjustFilterBlur alloc] initWithFrame:frame];
                adjustFilterBlur.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustFilterBlur];
            
            
        }break;
        case adjustFilterTypeConvex:{
        
            C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
            GPUImage.inputImage = _resultImage;
            self.IV_Image.image = [GPUImage GPUImageImageEffectWithEffect:@"GPUImageBulgeDistortionFilter"];
            
        }break;
        case adjustFilterTypePinch:{
        
            C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
            GPUImage.inputImage = _resultImage;
            self.IV_Image.image = [GPUImage GPUImageImageEffectWithEffect:@"GPUImagePinchDistortionFilter"];
            
        }break;
        case adjustFilterTypePixellate:{
        
            C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
            GPUImage.inputImage = _resultImage;
            self.IV_Image.image = [GPUImage GPUImageImageEffectWithEffect:@"GPUImagePixellateFilter"];
            
        }break;
        case adjustFilterTypeStretchDistortion:{
        
            C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
            GPUImage.inputImage = _resultImage;
            self.IV_Image.image = [GPUImage GPUImageImageEffectWithEffect:@"GPUImageStretchDistortionFilter"];
            
        }break;
        default:
            break;
    }
}

-(void)setAdjustType:(adjustType)adjustType{
    
    _adjustType = adjustType;
    
    [self.V_AdjustContent.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (adjustType) {
            
        case adjustTypeNormal:{
            
            self.resultImage = self.image;
            
        }break;
        case adjustTypBrightnesse:{
            
            if(adjustBrightness == nil){
                
                adjustBrightness = [[V_AdjustBrightness alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.V_AdjustContent.bounds)-50, MainBoundsSize.width, 50)];
                adjustBrightness.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustBrightness];
            
        }break;
        case adjustTypeSaturation:{
            
            if(adjustSaturation == nil){
                
                adjustSaturation = [[V_AdjustSaturation alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.V_AdjustContent.bounds)-50, MainBoundsSize.width, 50)];
                adjustSaturation.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustSaturation];
            
        }break;
        case adjustTypeWhiteBalance:{
            
            if(adjustWhiteBalance == nil){
                
                adjustWhiteBalance = [[V_AdjustWhiteBalance alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.V_AdjustContent.bounds)-50, MainBoundsSize.width, 50)];
                adjustWhiteBalance.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustWhiteBalance];
            
        }break;
        case adjustTypeContrast:{
            if(adjustContrast == nil){
                
                adjustContrast = [[V_AdjustContrast alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.V_AdjustContent.bounds)-50, MainBoundsSize.width, 50)];
                adjustContrast.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustContrast];
            
        }break;
        case adjustTypeRGB:{
            
            if(adjustRGB == nil){
                
                adjustRGB = [[V_AdjustRGB alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.V_AdjustContent.bounds)-130, MainBoundsSize.width, 130)];
                adjustRGB.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustRGB];
            
        }break;
        case adjustTypeExposure:{
        
            if(adjustExposure == nil){
            
                adjustExposure = [[V_AdjustExposure alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.V_AdjustContent.bounds)-50, MainBoundsSize.width, 50)];
                adjustExposure.delegate = self;
                
            }
            
            [self.V_AdjustContent addSubview:adjustExposure];
            
        }break;
        default:
            break;
    }
    
}


-(void)setImageEffectType:(imageEffectType)imageEffectType{

    _imageEffectType = imageEffectType;
    
    NSString *strEffect;
    
    switch (imageEffectType) {
        case imageEffectTypeNormal:{}break;
            
        case imageEffectTypeSepia:{
            
            strEffect = @"GPUImageSepiaFilter";
            
        }break;
            
        case imageEffectTypeSketch:{
            
            strEffect = @"GPUImageSketchFilter";
            
        }break;
            
        case imageEffectTypeToon:{
            
            strEffect = @"GPUImageSmoothToonFilter";
            
        }break;
            
        case imageEffectTypeVignette:{
            
            strEffect = @"GPUImageVignetteFilter";
            
        }break;
            
        case imageEffectTypeErosion:{
            
            strEffect = @"GPUImageErosionFilter";
            
        }break;
            
        case imageEffectTypeRGBErosion:{
            
            strEffect = @"GPUImageRGBErosionFilter";
            
        }break;
            
        case imageEffectTypeDilation:{
            
            strEffect = @"GPUImageClosingFilter";
            
        }break;
            
        case imageEffectTypeSphereRefraction:{
            
            strEffect = @"GPUImageSphereRefractionFilter";
            
        }break;
            
        case imageEffectTypeColorInvert:{
        
            strEffect = @"GPUImageColorInvertFilter";
            
        }
        default:
            break;
    }
    
    if(strEffect){
    
        C_GPUImage *GPUImage = [[C_GPUImage alloc] init];
        GPUImage.inputImage = self.image;
       self.IV_Image.image = [GPUImage GPUImageImageEffectWithEffect:strEffect];
        
    }else{
    
        self.IV_Image.image = self.image;
    }
}



-(void)setResultImage:(UIImage *)resultImage{
    
    _resultImage = resultImage;
    
    self.IV_Image.image = _resultImage;
    
}


-(void)setPhotoEditType:(PhotoEditType)PhotoEditType{
    
    _PhotoEditType = PhotoEditType;
    
    switch (_PhotoEditType) {
        case PhotoEditTypeAdjustColor:{
            
            arrayEffect = @[@"正常",@"对比度",@"色调",@"色温",@"饱和度",@"亮度",@"曝光度"];
            
        }break;
        case PhotoEditTypeAdjustEffect:{
            
            arrayEffect = @[@"正常",@"怀旧",@"素描",@"卡通",@"晕影",@"水墨画",@"水墨画带色",@"黑白照",@"水晶球",@"颜色反转"];
            
        }break;
        case PhotoEditTypeAdjustFilter:{
            
            arrayEffect = @[@"正常",@"锐化",@"浮雕效果",@"查找边缘",@"模糊",@"凸起",@"捏变形",@"像素化",@"拉伸"];
        }break;
        default:
            break;
    }
}

#pragma mark - 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
