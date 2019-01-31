//
//  UIImageView+ScaleImage.h
//  GoldTouTiao
//
//  Created by Micker on 16/5/12.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

@interface UIImageView (ScaleImage)

/*!
 *	压缩图片
 *
 *	@param image	image description
 */
- (void) scaleImage:(UIImage *) image;

/*!
 *	压缩图片到指定大小
 *
 *	@param image	image description
 *	@param size	size description
 */
- (void) scaleImage:(UIImage *) image toSize:(CGSize)size;

@end
