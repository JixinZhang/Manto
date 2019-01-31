//
//  UIView+Controller.h
//  GoldBaseFramework
//
//  Created by Micker on 16/5/20.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *	根据当前视图的nextResponder来寻找对应的Controller
 */
@interface UIView (Controller)

/*!
 *	根据当前视图的nextResponder来寻找对应的Controller
 *
 *	@return 如果存在，则返回，否则返回nil;
 */
- (UIViewController *) viewController;

@end
