//
//  UIImage-Extensions.h
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MImageInBundle(imageName, bundleName) \
[UIImage imageNamed:(imageName) bundle:(bundleName)]

//CGFloat DegreesToRadians(CGFloat degrees);
//CGFloat RadiansToDegrees(CGFloat radians);
CGFloat RadiansToDegrees(CGFloat radians);

NS_INLINE  UIImage *InlineScaledImageToMiniumuSize(UIImage *sourceImage,CGSize targetSize)
{
    //    UIImage *sourceImage = sourceImage;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) 
    {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor > heightFactor)
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
	}
    else 
    {
        return sourceImage;
    }
	
    newImage = [[UIImage alloc] initWithCGImage:sourceImage.CGImage scale:scaleFactor orientation:UIImageOrientationUp];

	if(!newImage) 
        NSLog(@"could not scale image");
	
	return newImage ;
}


@interface UIImage (extend)

- (UIImage *)subImageAtRect:(CGRect)rect;

- (UIImage *)imageScaledToSize:(CGSize)size;

- (UIImage *)imageScaledToWidth:(CGFloat)value;

- (UIImage *)imageScaledToHeight:(CGFloat)value;

- (UIImage *)imageScaledToSizeEx:(CGSize)size;

- (UIImage *)imageAtRect:(CGRect)rect;

- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

- (UIImage *) imageByScalingForWidth:(CGFloat)defineWidth;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;

- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

- (UIImage *)gaussianBlur;

- (UIImage *)fixOrientation;

- (CGFloat)resizableHeightWithFixedwidth:(CGFloat)width;

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

- (UIImage*)getGrayImage:(UIImage*)sourceImage;

+ (UIImage *) getLaunchImage;

- (UIImage *) rounderCornerImageWithRadius:(CGFloat)radius size:(CGSize)size;
- (UIImage *) rounderCornerImageWithRadius:(CGFloat)radius size:(CGSize)size corners:(UIRectCorner)corners;

+ (UIImage *) imageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size;
+ (UIImage *) imageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size corners:(UIRectCorner)corners;
+ (UIImage *) imageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size corners:(UIRectCorner)corners shadow:(CGSize)shadowSize offset:(CGFloat)shadowOffset;

+ (UIImage *) imageWithGradientColors:(CFArrayRef)colors locations:(const CGFloat *)locations size:(CGSize)size;
+ (UIImage *) imageWithLinearGradientColors:(CFArrayRef)colors
                                  locations:(const CGFloat *)locations
                                       size:(CGSize)size
                                      start:(CGPoint)startPoint
                                        end:(CGPoint)endPoint;

+ (UIImage *) imageByScreenShotWithView:(UIView *)targetView;

+ (UIImage *) imageNamed: (NSString *)imageName bundle: (NSString *)bundleName;

/**
 图片合成(绘制一张背景为纯色中间区域不变形的图)
 
 @param color 颜色
 @param size 生成到图片尺寸
 @return 合成后的图
 */
- (UIImage *)drawRectImageWithBorderColor: (UIColor *)color
                                     size: (CGSize )size;

@end

#pragma mark - IconFont

@interface UIImage (IconFont)

+ (UIImage *)iconFontImageWithText:(NSString *)iconFontText imageSize:(CGFloat)imageSize iconFontColor:(UIColor *)iconFontColor;

@end
