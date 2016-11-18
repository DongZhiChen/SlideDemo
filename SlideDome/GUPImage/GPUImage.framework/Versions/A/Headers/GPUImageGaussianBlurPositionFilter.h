#import "GPUImageTwoPassTextureSamplingFilter.h"

/** A more generalized 9x9 Gaussian blur filter
 */
@interface GPUImageGaussianBlurPositionFilter : GPUImageTwoPassTextureSamplingFilter 
{
    GLint blurCenterUniform, blurRadiusUniform, aspectRatioUniform;
}

/** A multiplier for the blur size, ranging from 0.0 on up, with a default of 1.0
 */

///模糊程度 越大越模糊
@property (readwrite, nonatomic) CGFloat blurSize;

/** Center for the blur, defaults to 0.5, 0.5
 */
///模糊中心点，（0~1）
@property (readwrite, nonatomic) CGPoint blurCenter;

/** Radius for the blur, defaults to 1.0
 */
///模糊半径，（圆形模糊）
@property (readwrite, nonatomic) CGFloat blurRadius;

@end
