//
//  BaseNavigationViewController.h
//  GoldBaseFramework
//
//  Created by Micker on 16/6/2.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *	@brief UIViewController (APSafeTransition), 解决7.0系统下面的快速push、pop的问题
 */
@interface UIViewController (APSafeTransition)


/**
 *  当前视图控制器即将销毁，手势\点击返回按钮均会进行触发
 *  注意，有别于dealloc
 *
 *  @parames
 */
- (void) viewControllerWillDestory;

@end

@interface UINavigationController (APSafeTransition)

@property(nonatomic, assign, getter = isTransitionInProgress) BOOL transitionInProgress;

@end

@interface BaseNavigationViewController : UINavigationController

@end
