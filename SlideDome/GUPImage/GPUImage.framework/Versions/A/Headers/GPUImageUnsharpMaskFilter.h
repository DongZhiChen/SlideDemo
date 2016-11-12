#import "GPUImageFilterGroup.h"

@class GPUImageGaussianBlurFilter;

@interface GPUImageUnsharpMaskFilter : GPUImageFilterGroup
{
    GPUImageGaussianBlurFilter *blurFilter;
    GPUImageFilter *unsharpMaskFilter;
}
// The blur radius of the underlying Gaussian blur. The default is 4.0.
///模糊程度
@property (readwrite, nonatomic) CGFloat blurRadiusInPixels;

// The strength of the sharpening, from 0.0 on up, with a default of 1.0
///锐化强度
@property(readwrite, nonatomic) CGFloat intensity;

@end
