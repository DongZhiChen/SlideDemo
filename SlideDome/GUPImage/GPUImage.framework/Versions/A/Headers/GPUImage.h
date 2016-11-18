#import "GLProgram.h"

// Base classes
#import "GPUImageContext.h"
#import "GPUImageOutput.h"
#import "GPUImageView.h"
#import "GPUImageVideoCamera.h"
#import "GPUImageStillCamera.h"
#import "GPUImageMovie.h"
#import "GPUImagePicture.h"
#import "GPUImageRawDataInput.h"
#import "GPUImageRawDataOutput.h"
#import "GPUImageMovieWriter.h"
#import "GPUImageFilterPipeline.h"
#import "GPUImageTextureOutput.h"
#import "GPUImageFilterGroup.h"
#import "GPUImageTextureInput.h"
#import "GPUImageUIElement.h"
#import "GPUImageBuffer.h"
#import "GPUImageFramebuffer.h"
#import "GPUImageFramebufferCache.h"

// Filters
#import "GPUImageFilter.h"
#import "GPUImageTwoInputFilter.h"
///图片像素画
#import "GPUImagePixellateFilter.h"
///根据Position来让图片像素化
#import "GPUImagePixellatePositionFilter.h"
///怀旧效果
#import "GPUImageSepiaFilter.h"
///颜色翻转效果
#import "GPUImageColorInvertFilter.h"
///饱和度
#import "GPUImageSaturationFilter.h"
///对比度 
#import "GPUImageContrastFilter.h"
///曝光度
#import "GPUImageExposureFilter.h"
///亮度
#import "GPUImageBrightnessFilter.h"
///色阶
#import "GPUImageLevelsFilter.h"
///锐化
#import "GPUImageSharpenFilter.h"
///伽马
#import "GPUImageGammaFilter.h"
///查找边缘
#import "GPUImageSobelEdgeDetectionFilter.h"
///素描效果
#import "GPUImageSketchFilter.h"
 //卡通效果（黑色粗线描边）
#import "GPUImageToonFilter.h"
//相比上面的效果更细腻
#import "GPUImageSmoothToonFilter.h"

///叠加
#import "GPUImageMultiplyBlendFilter.h"
//溶解
#import "GPUImageDissolveBlendFilter.h"

///桑原(Kuwahara)滤波,水粉画的模糊效果（没看出效果的？？）； 处理时间长
#import "GPUImageKuwaharaFilter.h"
#import "GPUImageKuwaharaRadius3Filter.h"
///晕影，形成黑色圆形边缘，突出中间图像的效果 执行一个渐晕效果，淡出图像的边缘
#import "GPUImageVignetteFilter.h"

///高斯模糊
#import "GPUImageGaussianBlurFilter.h"
#import "GPUImageGaussianBlurPositionFilter.h"
///取消圆形区域的高斯模糊
#import "GPUImageGaussianSelectiveBlurFilter.h"
///叠加,通常用于创建阴影效果
#import "GPUImageOverlayBlendFilter.h"
///加深混合,通常用于重叠类型
#import "GPUImageDarkenBlendFilter.h"
///减淡混合,通常用于重叠类型
#import "GPUImageLightenBlendFilter.h"
///水旋涡
#import "GPUImageSwirlFilter.h"
 //源混合
#import "GPUImageSourceOverBlendFilter.h"
///颜色混合
#import "GPUImageColorBurnBlendFilter.h"
///颜色混合
#import "GPUImageColorDodgeBlendFilter.h"
 //屏幕包裹,通常用于创建亮点和镜头眩光
#import "GPUImageScreenBlendFilter.h"
 //排除混合
#import "GPUImageExclusionBlendFilter.h"
//差异混合,通常用于创建更多变动的颜色
#import "GPUImageDifferenceBlendFilter.h"
//差值混合,通常用于创建两个图像之间的动画变暗模糊效果
#import "GPUImageSubtractBlendFilter.h"
 //强光混合,通常用于创建阴影效果
#import "GPUImageHardLightBlendFilter.h"
//柔光混合
#import "GPUImageSoftLightBlendFilter.h"
#import "GPUImageColorBlendFilter.h"
#import "GPUImageHueBlendFilter.h"
#import "GPUImageSaturationBlendFilter.h"
#import "GPUImageLuminosityBlendFilter.h"
///图片剪切
#import "GPUImageCropFilter.h"
///图片变灰效果
#import "GPUImageGrayscaleFilter.h"
///转换，2D,3D
#import "GPUImageTransformFilter.h"
 //色度键混合
#import "GPUImageChromaKeyBlendFilter.h"
///阴霾效果
#import "GPUImageHazeFilter.h"
///亮度阈值
#import "GPUImageLuminanceThresholdFilter.h"
///色调分离
#import "GPUImagePosterizeFilter.h"
//盒状模糊
#import "GPUImageBoxBlurFilter.h"
///自适应阈值(真素描)
#import "GPUImageAdaptiveThresholdFilter.h"
///曝光度
#import "GPUImageSolarizeFilter.h"
///锐化
#import "GPUImageUnsharpMaskFilter.h"
///凸起变形
#import "GPUImageBulgeDistortionFilter.h"
///捏变形
#import "GPUImagePinchDistortionFilter.h"
///线条
#import "GPUImageCrosshatchFilter.h"
///CGA的色彩
#import "GPUImageCGAColorspaceFilter.h"
///像极光效果的像素化
#import "GPUImagePolarPixellateFilter.h"
///拉伸
#import "GPUImageStretchDistortionFilter.h"
//填满柏林噪波
#import "GPUImagePerlinNoiseFilter.h"

#import "GPUImageJFAVoronoiFilter.h"
#import "GPUImageVoronoiConsumerFilter.h"
 //黑白马赛克
#import "GPUImageMosaicFilter.h"
//条纹模糊，中间清晰，上下两端模糊
#import "GPUImageTiltShiftFilter.h"
///使图片变亮变暗吧
#import "GPUImage3x3ConvolutionFilter.h"
///浮雕效果
#import "GPUImageEmbossFilter.h"
///Canny边缘检测
#import "GPUImageCannyEdgeDetectionFilter.h"
///阈值边缘检测
#import "GPUImageThresholdEdgeDetectionFilter.h"
///蒙版
#import "GPUImageMaskFilter.h"
//色彩直方图，显示在图片上
#import "GPUImageHistogramFilter.h"
//色彩直方图
#import "GPUImageHistogramGenerator.h"
#import "GPUImageHistogramEqualizationFilter.h"
///预留边缘检测
#import "GPUImagePrewittEdgeDetectionFilter.h"
//XYDerivative边缘检测，画面以蓝色为主，绿色为边缘，带彩色
#import "GPUImageXYDerivativeFilter.h"
 //Harris角点检测，会有绿色小十字显示在图片角点处
#import "GPUImageHarrisCornerDetectionFilter.h"
///透明混合
#import "GPUImageAlphaBlendFilter.h"
 //正常
#import "GPUImageNormalBlendFilter.h"
 //非最大抑制，只显示亮度最高的像素，其他为黑
#import "GPUImageNonMaximumSuppressionFilter.h"
///色调
#import "GPUImageRGBFilter.h"
 //中间值，有种稍微模糊边缘的效果
#import "GPUImageMedianFilter.h"
///双向模糊
#import "GPUImageBilateralFilter.h"
///十字线
#import "GPUImageCrosshairGenerator.h"
///色调曲线
#import "GPUImageToneCurveFilter.h"
///Noble点检测
#import "GPUImageNobleCornerDetectionFilter.h"
#import "GPUImageShiTomasiFeatureDetectionFilter.h"
///腐蚀（水墨画）
#import "GPUImageErosionFilter.h"
///水墨画带色
#import "GPUImageRGBErosionFilter.h"
///变黑白照吧
#import "GPUImageDilationFilter.h"
///像水粉画
#import "GPUImageRGBDilationFilter.h"
///变黑白照
#import "GPUImageOpeningFilter.h"
#import "GPUImageRGBOpeningFilter.h"
///黑白画
#import "GPUImageClosingFilter.h"
#import "GPUImageRGBClosingFilter.h"
///没有颜色
#import "GPUImageColorPackingFilter.h"
///水晶球，折射
#import "GPUImageSphereRefractionFilter.h"

#import "GPUImageMonochromeFilter.h"
///图片透明度
#import "GPUImageOpacityFilter.h"
///高光阴影
#import "GPUImageHighlightShadowFilter.h"

#import "GPUImageFalseColorFilter.h"
///HSB色彩模式
#import "GPUImageHSBFilter.h"
///色度
#import "GPUImageHueFilter.h"
///玻璃球
#import "GPUImageGlassSphereFilter.h"
//lookup 色彩调整
#import "GPUImageLookupFilter.h"
#import "GPUImageAmatorkaFilter.h"
#import "GPUImageMissEtikateFilter.h"
#import "GPUImageSoftEleganceFilter.h"
#import "GPUImageAddBlendFilter.h"
#import "GPUImageDivideBlendFilter.h"
///图层上加 波尔卡圆点
#import "GPUImagePolkaDotFilter.h"
#import "GPUImageLocalBinaryPatternFilter.h"
#import "GPUImageColorLocalBinaryPatternFilter.h"
#import "GPUImageLanczosResamplingFilter.h"
#import "GPUImageAverageColor.h"
#import "GPUImageSolidColorGenerator.h"
#import "GPUImageLuminosity.h"
///平均亮度阈值
#import "GPUImageAverageLuminanceThresholdFilter.h"
//白平衡 (色温，色彩补偿)
#import "GPUImageWhiteBalanceFilter.h"
///色度
#import "GPUImageChromaKeyFilter.h"
///可以调亮度
#import "GPUImageLowPassFilter.h"
#import "GPUImageHighPassFilter.h"

#import "GPUImageMotionDetector.h"
///添加网板效果
#import "GPUImageHalftoneFilter.h"
#import "GPUImageThresholdedNonMaximumSuppressionFilter.h"

#import "GPUImageHoughTransformLineDetector.h"

#import "GPUImageParallelCoordinateLineTransformFilter.h"
///阈值素描
#import "GPUImageThresholdSketchFilter.h"
#import "GPUImageLineGenerator.h"
#import "GPUImageLinearBurnBlendFilter.h"
#import "GPUImageGaussianBlurPositionFilter.h"
///圆形区域像素化
#import "GPUImagePixellatePositionFilter.h"

#import "GPUImageTwoInputCrossTextureSamplingFilter.h"
#import "GPUImagePoissonBlendFilter.h"
///运动模糊 （晕死）
#import "GPUImageMotionBlurFilter.h"
///变焦模糊（也😓）
#import "GPUImageZoomBlurFilter.h"

#import "GPUImageLaplacianFilter.h"
///iOS磨砂
#import "GPUImageiOSBlurFilter.h"
///亮度ba 
#import "GPUImageLuminanceRangeFilter.h"
///像黑板画，边缘检测
#import "GPUImageDirectionalNonMaximumSuppressionFilter.h"
#import "GPUImageDirectionalSobelEdgeDetectionFilter.h"
///黑白模糊
#import "GPUImageSingleComponentGaussianBlurFilter.h"

#import "GPUImageThreeInputFilter.h"
#import "GPUImageFourInputFilter.h"
#import "GPUImageWeakPixelInclusionFilter.h"
#import "GPUImageColorConversion.h"
#import "GPUImageColourFASTFeatureDetector.h"
#import "GPUImageColourFASTSamplingOperation.h"

