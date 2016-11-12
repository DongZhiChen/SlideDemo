#import "GPUImageFilterGroup.h"

@class GPUImageGaussianBlurFilter;

/** A Gaussian blur that preserves focus within a circular region
 */
@interface GPUImageGaussianSelectiveBlurFilter : GPUImageFilterGroup 
{
    GPUImageGaussianBlurFilter *blurFilter;
    GPUImageFilter *selectiveFocusFilter;
    BOOL hasOverriddenAspectRatio;
}

/** The radius of the circular area being excluded from the blur
 */
///取消模糊圆形区域半径
@property (readwrite, nonatomic) CGFloat excludeCircleRadius;
/** The center of the circular area being excluded from the blur
 */
///取消模糊圆形区域的point (0~1)
@property (readwrite, nonatomic) CGPoint excludeCirclePoint;
/** The size of the area between the blurred portion and the clear circle
 */
///取消模糊圆形区域的大小
@property (readwrite, nonatomic) CGFloat excludeBlurSize;
/** A radius in pixels to use for the blur, with a default of 5.0. This adjusts the sigma variable in the Gaussian distribution function.
 */
///模糊程度
@property (readwrite, nonatomic) CGFloat blurRadiusInPixels;
/** The aspect ratio of the image, used to adjust the circularity of the in-focus region. By default, this matches the image aspect ratio, but you can override this value.
 */

///纵横比 1/1 (圆) 3/10 (形成比较高的圆角矩形)
@property (readwrite, nonatomic) CGFloat aspectRatio;

@end
