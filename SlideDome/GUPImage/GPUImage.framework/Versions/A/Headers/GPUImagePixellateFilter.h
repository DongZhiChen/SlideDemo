#import "GPUImageFilter.h"

@interface GPUImagePixellateFilter : GPUImageFilter
{
    GLint fractionalWidthOfAPixelUniform, aspectRatioUniform;
}

// The fractional width of the image to use as a size for the pixels in the resulting image. Values below one pixel width in the source image are ignored.

///将图片像素画，以图片大小为分数的大小（200*200） -》 1/200
@property(readwrite, nonatomic) CGFloat fractionalWidthOfAPixel;


@end
