#import "GPUImageFilter.h"

@interface GPUImageCropFilter : GPUImageFilter
{
    GLfloat cropTextureCoordinates[8];
}

// The crop region is the rectangle within the image to crop. It is normalized to a coordinate space from 0.0 to 1.0, with 0.0, 0.0 being the upper left corner of the image
///图片剪切（x,y,width,height）取值(0~1)
@property(readwrite, nonatomic) CGRect cropRegion;

// Initialization and teardown
- (id)initWithCropRegion:(CGRect)newCropRegion;

@end
