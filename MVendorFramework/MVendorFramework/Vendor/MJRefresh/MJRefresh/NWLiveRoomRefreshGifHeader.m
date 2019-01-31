//
//  NWLiveRoomRefreshGifHeader.m
//  News
//
//  Created by wscn on 16/4/14.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import "NWLiveRoomRefreshGifHeader.h"

@interface NWLiveRoomRefreshGifHeader()


@end

@implementation NWLiveRoomRefreshGifHeader


#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    [self localRefreshGif];
    [self dealRefreshAd];
}

- (void)localRefreshGif{
    
    NSMutableArray *idleImages = [NSMutableArray array];
    NSMutableArray *PullingImages = [NSMutableArray array];

    for (NSUInteger i = 0; i<=27; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"refresh_27"]] forState:MJRefreshStatePulling];

    [self setImages:idleImages forState:MJRefreshStateRefreshing];

//    for (NSUInteger i = 9; i<=30; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%zd", i]];
//        [PullingImages addObject:image];
//    }
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//
//    [self setImages:@[[UIImage imageNamed:@"refresh_30"]] forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    [self setImages:PullingImages forState:MJRefreshStateRefreshing];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullDownRefreshImage:) name:@"NotificationPullRefreshAd" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pullDownStateLabel:) name:@"NotificationPullRefreshStateLabel" object:nil];
        [self updatePullRefreshStateLabel];

    }
    return self;
}

- (void)pullDownRefreshImage:(NSNotification *)notification
{
    [self dealRefreshAd];
}

- (void)pullDownStateLabel:(NSNotification *)notification
{
    [self updatePullRefreshStateLabel];
    
}

- (void)removeMJRefreshTime {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
