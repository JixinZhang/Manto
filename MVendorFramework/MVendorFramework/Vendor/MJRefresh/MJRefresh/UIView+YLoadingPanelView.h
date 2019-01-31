//
//  UIView+YLoadingPanelView.h
//  MVendorFramework
//
//  Created by wscn on 16/12/6.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLoadingPanel.h"

@interface YLoadingPanelBaseView : UIControl

@property (nonatomic, strong) UIView *loadView;
@property (nonatomic, strong) YLoadingPanel *loadingPanelView;
@property (nonatomic, strong) UIImageView *reloadImageView;
@property (nonatomic, strong) UIImage *reloadImage;
@property (nonatomic, copy) void (^reloadBlock)();

@end


@interface UIView (YLoadingPanelView)

@property (nonatomic, strong) YLoadingPanelBaseView *loadingPanelBaseView;

//自定义动画的Y值，默认是该view的中心点
- (void) loadingPanelFrameY:(CGFloat)y;
//自定义加载失败后出现imageView的Y值，默认是该view的中心点
- (void) reloadImageViewFrameY:(CGFloat)y;


//显示并开始加载动画(自动调用startLoading)
- (void) showLoadingPanelView;

//如果是isSuccess为Yes，后面errorBlock为nil，如果为No，点击时block为回调
//如果为yes，会自动调用completeLoading,如果为No，会自动调用errorLoading;
//点击会自动调用showLoadingPanelView
- (void) showSuccess:(BOOL)isSuccess withErrorBlock:(void (^)())block;



//开始加载
- (void) startLoading;
//加载出错
- (void) errorLoading;
//完成加载
- (void) completeLoading;

@end
