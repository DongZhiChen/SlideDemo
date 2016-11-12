#import "GPUImageFilter.h"

/// Creates a bulge distortion on the image
@interface GPUImageBulgeDistortionFilter : GPUImageFilter
{
    GLint aspectRatioUniform, radiusUniform, centerUniform, scaleUniform;
}

/// The center about which to apply the distortion, with a default of (0.5, 0.5)
@property(readwrite, nonatomic) CGPoint center;
/// The radius of the distortion, ranging from 0.0 to 1.0, with a default of 0.25
///突破的半径
@property(readwrite, nonatomic) CGFloat radius;
/// The amount of distortion to apply, from -1.0 to 1.0, with a default of 0.5
///凸起变大比例（< 0 变小 ， > 0 变大）
@property(readwrite, nonatomic) CGFloat scale;

@end
