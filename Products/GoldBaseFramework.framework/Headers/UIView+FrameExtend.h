//
//  UIView+FrameExtend.h
//  GoldBaseFramework
//
//  Created by Micker on 16/8/19.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat CGFloatAspectX(CGFloat xValue, CGFloat widthValue);
CGFloat CGFloatAspectY(CGFloat yValue, CGFloat heightValue);

/*!
 *	对视图的frame/bounds的快捷设置，并以链式进行简单封装
 */
@interface UIView (FrameExtend)

/*!
*	@return self.frame.origin.x
*/
- (int)x;

/*!
 *	@return self.frame.origin.y
 */
- (int)y;

/*!
 *	@return self.frame.size.width
 */
- (int)width;

/*!
 *	@return self.frame.size.height
 */
- (int)height;

/*!
 *	@return self.bounds.origin.x
 */
- (int)boundsX;

/*!
 *	@return self.bounds.origin.y
 */
- (int)boundsY;

/*!
 *	@return self.bounds.size.width
 */
- (int)boundsWidth;

/*!
 *	@return self.bounds.size.height
 */
- (int)boundsHeight;

/*!
 *	@return self.frame.origin.x + self.frame.size.width
 */
- (int)maxWidth;

/*!
 *	@return self.frame.origin.y + self.frame.size.height
 */
- (int)maxHeight;

/*!
 *	链式封装setFrame
 *
 *	@param frame	frame description
 *
 *	@return self
 */
- (UIView *) setViewFrameEX:(CGRect) frame;

/*!
 *	链式封装setFrame X
 *
 *	@param x	x description
 *
 *	@return self
 */
- (UIView *) setViewFrameX:(CGFloat) x;

/*!
 *	链式封装setFrame Y
 *
 *	@param y	y description
 *
 *	@return self
 */
- (UIView *) setViewFrameY:(CGFloat) y;

/*!
 *	链式封装setFrame width
 *
 *	@param width    width description
 *
 *	@return self
 */
- (UIView *) setViewFrameWidth:(CGFloat) width;

/*!
 *	链式封装setFrame height
 *
 *	@param height	height description
 *
 *	@return self
 */
- (UIView *) setViewFrameHeight:(CGFloat) height;

/*!
 *	链式封装set bounds X
 *
 *	@param x	x description
 *
 *	@return self
 */
- (UIView *) setViewBoundsX:(CGFloat) x;

/*!
 *	链式封装set bounds Y
 *
 *	@param y	y description
 *
 *	@return self
 */
- (UIView *) setViewBoundsY:(CGFloat) y;

/*!
 *	链式封装set bounds width
 *
 *	@param width  width description
 *
 *	@return self
 */
- (UIView *) setViewBoundsWidth:(CGFloat) width;

/*!
 *	链式封装set bounds height
 *
 *	@param height  height description
 *
 *	@return self
 */
- (UIView *) setViewBoundsHeight:(CGFloat) height;

/*!
 *	链式封装set frame origin
 *
 *	@param origin  origin description
 *
 *	@return self
 */
- (UIView *) setViewFrameOrigin:(CGPoint) origin;

/*!
 *	链式封装set frame size
 *
 *	@param size  size description
 *
 *	@return self
 */
- (UIView *) setViewFrameSize:(CGSize) size;

/*!
 *	链式封装set bounds origin
 *
 *	@param origin  origin description
 *
 *	@return self
 */
- (UIView *) setViewBoundsOrigin:(CGPoint) origin;

/*!
 *	链式封装set bounds size
 *
 *	@param size  size description
 *
 *	@return self
 */
- (UIView *) setViewBoundsSize:(CGSize) size;

/*!
 *	扩充垂直高度
 *
 *	@param height	扩充量
 *
 *	@return self
 */
- (UIView *) setViewExtendHeight:(CGFloat) height;

/*!
 *	扩充宽度
 *
 *	@param width	扩充量
 *
 *	@return self
 */
- (UIView *) setViewExtendWidth:(CGFloat) width;

/*!
 *	垂直偏移
 *
 *	@param vertical	偏移量
 *
 *	@return self
 */
- (UIView *) setShiftVertical:(CGFloat) vertical;

/*!
 *	水平偏移
 *
 *	@param horizon	偏移量
 *
 *	@return self
 */
- (UIView *) setShiftHorizon:(CGFloat) horizon;

/*!
 *	使用子视图填充父视图
 *
 *	@param subView	子视图
 *
 *	@return self
 */
- (UIView *) addFillSubView:(UIView *) subView;

/*!
 *	添加居中的子视图
 *
 *	@param subView	子视图
 *
 *	@return self
 */
- (UIView *) addCenterSubview:(UIView *) subView;

/*!
 *	添加带有y偏移量的子视图
 *
 *	@param subView	子视图
 *	@param yShift	y偏移量
 *
 *	@return self
 */
- (UIView *) addCenterSubview:(UIView *) subView shiftOriginY:(int) yShift;

/*!
 *	添加带有x偏移量的子视图
 *
 *	@param subView	子视图
 *	@param xShift	x偏移量
 *
 *	@return self
 */
- (UIView *) addCenterSubview:(UIView *) subView shiftOriginX:(int) xShift;

/*!
 *	添加带有偏移量的子视图
 *
 *	@param subView	子视图
 *	@param shift	偏移量
 *
 *	@return self
 */
- (UIView *) addCenterSubview:(UIView *) subView shiftOrigin:(CGPoint) shift;


/*!
 *	清空所有子视图
 *
 *	@return 当前对象，方便使用链式
 */
- (UIView *) emptySubviews;

/**
 *  UIView添加背景图片，view大小为图片大小
 */
/*!
 *  UIView添加背景图片，view大小为图片大小
 *
 *	@param imageName		imageName   本地图片名称
 *
 *	@return 具体的UIImageView
 */
- (UIView *) addBackgroundImage:(NSString *)imageName;

/*!
 *	UIView添加背景图片，图片拉伸为view大小
 *
 *	@param imageName		imageName   本地图片名称
 *	@param leftCapWidth	leftCapWidth    左边距离
 *	@param topCapHeight	topCapHeight    顶上的距离
 *
 *	@return 具体的UIImageView
 */
- (UIImageView *) addBackgroundStretchableImage:(NSString *)imageName
                                   leftCapWidth:(CGFloat)leftCapWidth
                                   topCapHeight:(CGFloat)topCapHeight;


/*!
 *    链式封装set bounds center x
 *
 *    @param centerX  centerX
 *
 *    @return self
 */
- (UIView *)setViewCenterX : (CGFloat) centerX;
/*!
 *    链式封装set bounds center y
 *
 *    @param centerY  centerY
 *
 *    @return self
 */
- (UIView *)setViewCenterY : (CGFloat) centerY;
@end
