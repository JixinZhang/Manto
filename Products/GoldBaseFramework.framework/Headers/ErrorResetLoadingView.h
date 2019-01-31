//
//  ErrorResetLoadingView.h
//  GoldBaseFramework
//
//  Created by 朱义 on 2017/7/14.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorResetLoadingView : UIControl

@end

#pragma mark UIView ( emptyView )

@interface UIView (errorResetView)

@property (nonatomic, strong) ErrorResetLoadingView   *errorResetLoadingView;

/**
 显示带有提示标签的空视图，注意，若未主动设置baseEmptyView，则使用默认空视图【220 * 200】，且在当前视图的正中间
 
 */
- (void) showErrorResetLoadingViewBlock:(void (^)())block;

/**
 隐藏当前空视图
 */
- (void) hideErrorResetLoadingView;

- (void) updateErrorResetLoadingViewFrameY:(CGFloat)viewY;

@end
