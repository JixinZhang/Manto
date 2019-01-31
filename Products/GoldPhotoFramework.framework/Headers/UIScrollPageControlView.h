//
//  UIScrollPageControlView.h
//  DW
//
//  Created by Micker on 15/6/25.
//  Copyright (c) 2015年 micker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+PageControl.h"


@class UIScrollPageControlView;

@interface UIView(_reuseIdentifier)

@property (nonatomic, copy) NSString *reuseIdentifier;

@end

@protocol UIScrollPageControlViewDelegate <NSObject>

@required

- (NSUInteger) numberOfView:(UIScrollPageControlView *) control;

- (UIView *) configItemOfControl:(UIScrollPageControlView *) control at:(NSUInteger) index ;

@optional

- (CGFloat) minimumRowSpacing:(UIScrollPageControlView *) control;

- (void) reconfigItemOfControl:(UIScrollPageControlView *)control at:(NSUInteger) index withView:(UIView *)view;

@end

@protocol UIScrollPagePanGestureDelegate <NSObject>


/**
 手势状态切换代码
 
 @param state 手势状态
 @param flag 是否结束
 @param trans 偏移值
 */
- (void) onPanGestureStateChanged:(UIGestureRecognizerState) state isFinshed:(BOOL) flag trans:(float) trans;

@end


@interface UIScrollPageControlView : UIView

@property (nonatomic, strong) UIScrollView                          *scrollView;
@property (nonatomic, assign) BOOL                                  enablePageControl;  //默认为YES
@property (nonatomic, assign, readonly) NSInteger                   currentIndex;       //当前展示
@property (nonatomic, assign, readonly) UIView                      *currentView;       //当前展示的视图

@property (nonatomic, assign) id<UIScrollPageControlViewDelegate>   delegate;
@property (nonatomic, assign) id<UIScrollPagePanGestureDelegate>    panDelegate;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer      *panGesture;        //缩放手势

- (void) setViewIndex:(NSUInteger) index animated:(BOOL)animated;

- (CGFloat) itemWidth;

- (UIView *) dequeueReusableViewWithIdentifier:(NSString *) identifier;

- (void) reloadData;

- (void) enablePanGesture:(BOOL) enable;

@end
