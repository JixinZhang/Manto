//
//  UIView+LoadingView.h
//  GoldBaseFramework
//
//  Created by wscn on 2016/11/28.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoldBaseFramework/GoldBaseFramework.h>

@interface UIBaseLoadingView : UIControl

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, copy) void (^block)();
//@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@interface UIView (LoadingView)

@property (nonatomic, strong) UIBaseLoadingView *loadingView;

- (void) showSpecialLoadingView:(BOOL )flag;

- (void) showErrors: (NSString *) error block:(void (^)())block;

- (void) setLoadingViewFrameX: (CGFloat )x frameY: (CGFloat )y;

- (UIImage *)getLoadingImge;

- (UIImage *)getLoadingErrorImage;

@end
