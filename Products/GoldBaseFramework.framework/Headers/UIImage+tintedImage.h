//
//  UIImage+tintedImage.h
//  QBTitleView
//
//  Created by Katsuma Tanaka on 2013/01/17.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintedImage)

/*!
 *	使用颜色生成图片
 *
 *	@param color	color description
 *
 *	@return return value description
 */
- (UIImage *)tintedImageUsingColor:(UIColor *)color;


/*!
 *	使用颜色生成图片
 *
 *	@param color			color description
 *	@param imageSize	imageSize description
 *
 *	@return return value description
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)imageSize;


/**
 使用auto_wscn_placeholder生成尺寸为imageSize的占位图

 @param imageSize 图片大小
 @return image
 */
+ (UIImage *) wscnPlaceHolderSize:(CGSize) imageSize night:(BOOL) night;


/**
 使用imageName的图片生成尺寸为imageSize的占位图


 @param imageName 内部图片名称
 @param color 底色
 @param imageSize 尺寸大小
 @return image
 */
+ (UIImage *) placeHolder:(NSString *) imageName color:(UIColor *) color size:(CGSize) imageSize ratio:(CGFloat) ratio;

@end
