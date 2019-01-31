//
//  UIView+YLoadingPanelView.m
//  MVendorFramework
//
//  Created by wscn on 16/12/6.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "UIView+YLoadingPanelView.h"
#import <objc/runtime.h>


@implementation YLoadingPanelBaseView

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loadView];
        [self.loadView addSubview:self.loadingPanelView];
        [self addSubview:self.reloadImageView];
    }
    return self;
}

-(UIView *)loadView {
    if (!_loadView) {
        _loadView = [[UIView alloc] init];
        _loadView.backgroundColor = [UIColor clearColor];
        _loadView.center = self.center;
        _loadView.bounds = self.bounds;
        _loadView.hidden = YES;
        _loadView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _loadView;
}

-(YLoadingPanel *)loadingPanelView {
    if (!_loadingPanelView) {
        _loadingPanelView = [[YLoadingPanel alloc] init];
        _loadingPanelView.frame = self.bounds;
        _loadingPanelView.internalSpacing = 8.0f;
        _loadingPanelView.backgroundColor = [UIColor clearColor];
        _loadingPanelView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

    }
    return _loadingPanelView;
}

-(UIImageView *)reloadImageView {
    if (!_reloadImageView) {
        _reloadImageView = [[UIImageView alloc] init];
        _reloadImageView.hidden = YES;
        _reloadImageView.backgroundColor = [UIColor clearColor];
        _reloadImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

        [self setReloadImage:[UIImage imageNamed:@"reload"]];
    }
    return _reloadImageView;
}

-(void)setReloadImage:(UIImage *)reloadImage {
    if (!reloadImage) {
        return;
    }
    _reloadImage = reloadImage;
    CGSize size = reloadImage.size;
    self.reloadImageView.image = reloadImage;
    self.reloadImageView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    self.reloadImageView.bounds = CGRectMake(0, 0, size.width, size.height);
}



@end


@implementation UIView (YLoadingPanelView)

@dynamic loadingPanelBaseView;

- (YLoadingPanelBaseView *)loadingPanelBaseView {
    YLoadingPanelBaseView *_loadingPanelBaseView = objc_getAssociatedObject(self, _cmd);
    if (!_loadingPanelBaseView) {
        _loadingPanelBaseView = [[YLoadingPanelBaseView alloc] initWithFrame:self.bounds];
        [_loadingPanelBaseView addTarget:self action:@selector(touchImageAction:) forControlEvents:UIControlEventTouchUpInside];
        _loadingPanelBaseView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        objc_setAssociatedObject(self, _cmd, _loadingPanelBaseView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _loadingPanelBaseView;
}

- (IBAction)touchImageAction:(id)sender {
    if (self.loadingPanelBaseView.reloadBlock) {
        [self showLoadingPanelView];
        self.loadingPanelBaseView.reloadBlock();
        self.loadingPanelBaseView.reloadBlock = nil;
    }
}

- (void) showLoadingPanelView{
    if (![self.subviews containsObject:self.loadingPanelBaseView]) {
        [self addSubview:self.loadingPanelBaseView];
    }
    [self startLoading];
}

//开始加载
- (void)startLoading {
    self.loadingPanelBaseView.loadView.hidden = NO;
    [self.loadingPanelBaseView.loadingPanelView doPageLoadingAnimation];
    self.loadingPanelBaseView.reloadImageView.hidden = YES;
}

//加载出错
- (void)errorLoading {
    self.loadingPanelBaseView.reloadImageView.hidden = NO;
    self.loadingPanelBaseView.loadView.hidden = YES;
    [self.loadingPanelBaseView.loadingPanelView stopPageLoadingAnimation];
}

//完成加载
- (void)completeLoading {
    self.loadingPanelBaseView.loadView.hidden = YES;
    self.loadingPanelBaseView.reloadImageView.hidden = YES;
    [self.loadingPanelBaseView.loadingPanelView stopPageLoadingAnimation];
    [self.loadingPanelBaseView removeFromSuperview];
}


- (void) showSuccess:(BOOL)isSuccess withErrorBlock:(void (^)())block {
    if (isSuccess) {
        [self completeLoading];
    } else {
        self.loadingPanelBaseView.reloadBlock = block;
        [self errorLoading];
    }
    
}

- (void)loadingPanelFrameY:(CGFloat)y {
    CGRect panelViewFrame = self.loadingPanelBaseView.loadingPanelView.frame;
    panelViewFrame.origin.y = y;
     self.loadingPanelBaseView.loadingPanelView.frame = panelViewFrame;
}

- (void)reloadImageViewFrameY:(CGFloat)y {
    CGRect imageViewFrame = self.loadingPanelBaseView.reloadImageView.frame;
    imageViewFrame.origin.y = y;
    self.loadingPanelBaseView.reloadImageView.frame = imageViewFrame;
}

@end
