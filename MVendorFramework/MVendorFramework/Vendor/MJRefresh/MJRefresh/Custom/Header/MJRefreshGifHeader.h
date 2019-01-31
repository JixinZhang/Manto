//
//  MJRefreshGifHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshStateHeader.h"

typedef NS_ENUM(NSInteger, PullRefreshStateLabelStyle){
    PullRefreshStateStyleNone   = 1,
    PullRefreshStateStyleRight = 2,
    PullRefreshStateStyleBottom   = 3
};

@interface MJRefreshGifHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *gifView;
@property (strong, nonatomic) UIImageView *backImageView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;

@property (assign, nonatomic) PullRefreshStateLabelStyle labelStateStyle;
@property (assign, nonatomic) BOOL hasAd;
/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;

- (void)updatePullRefreshFrame;
- (void)updatePullRefreshStateLabel;

- (void)backImage:(NSString *)backImageUrlString;
- (void)dealRefreshAd;

- (void)removeRefreshAd;
- (void)removeLoadingPanelCircles;
- (void)doAutoRefreshloadingPanel;
- (BOOL)isLoadingPanelAnimation;
- (void)reStartAnimation;
- (void)gifViewReStartAnimation;

@end
