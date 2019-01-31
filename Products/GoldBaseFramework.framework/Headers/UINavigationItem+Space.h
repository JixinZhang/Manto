//
//  UINavigationItem+Space.h
//  B5MUIFramework
//
//  Created by Micker on 16/2/26.
//  Copyright © 2016年 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *	解决左、右导航按钮距离边界的太大的问题
 */
@interface UINavigationItem (Space)


/*!
 *	生成默认的item
 *
 *	@return return value description
 */
- (UIBarButtonItem *)spacer;
/*!
 *	生成指定宽度的item
 *
 *	@param value	value description
 *
 *	@return return value description
 */
- (UIBarButtonItem *)spacerWith:(CGFloat) value;

/*!
 *	右边按钮的item
 *
 *	@return return value description
 */
- (UIBarButtonItem *)rightSpacer;

/*!
 *	快捷设置左边按钮集
 *
 *	@param barButton	barButton description
 */
-(void) setSpaceLeftBarButtonItem:(UIBarButtonItem*)barButton;

/*!
 *	快捷设置右边按钮集
 *
 *	@param barButton	<#barButton description#>
 */
-(void) setSpaceRightBarButtonItem:(UIBarButtonItem*)barButton;

@end
