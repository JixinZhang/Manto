//
//  MJRefreshGifHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshGifHeader.h"
#import "YLoadingPanel.h"
//#import <UIImageView+WebCache.h>

@interface MJRefreshGifHeader()
{
    __unsafe_unretained UIImageView *_gifView;
}

/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@property (strong, nonatomic) YLoadingPanel *loadingPanel;
@end

@implementation MJRefreshGifHeader

@synthesize refreshHeight = _refreshHeight;

#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) { 
        UIImageView *gifView = [[UIImageView alloc] init];
        //gifView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_gifView = gifView];
    } 
    return _gifView; 
}

- (NSMutableDictionary *)stateImages 
{ 
    if (!_stateImages) {
        _stateImages = [NSMutableDictionary dictionary];
    } 
    return _stateImages; 
}

- (NSMutableDictionary *)stateDurations 
{ 
    if (!_stateDurations) { 
        _stateDurations = [NSMutableDictionary dictionary];
    } 
    return _stateDurations; 
}

-(UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backImageView.backgroundColor = [UIColor clearColor];
    }
    return _backImageView;
}

-(YLoadingPanel *)loadingPanel {
    if (!_loadingPanel) {
        _loadingPanel = [[YLoadingPanel alloc]init];
        _loadingPanel.frame = self.bounds;
        _loadingPanel.hidden = YES;
        _loadingPanel.backgroundColor = [UIColor clearColor];
        _loadingPanel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    return _loadingPanel;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state 
{ 
    if (images == nil) return;
    
    self.stateImages[@(state)] = images; 
    self.stateDurations[@(state)] = @(duration); 
    
    /* 根据图片设置控件的高度 */ 
    UIImage *image = [images firstObject]; 
    if (image.size.height > self.mj_h) { 
        self.mj_h = image.size.height; 
    } 
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state 
{ 
    [self setImages:images duration:images.count * 0.02 forState:state];
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    [self insertSubview:self.backImageView atIndex:0];
    [self addSubview:self.loadingPanel];
    // 初始化间距
    self.labelLeftInset = 20;
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    
    if (_stateImages.count > 0){
        if (!self.hasAd) {
            [super setPullingPercent:pullingPercent];
            NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
            if (self.state != MJRefreshStateIdle || images.count == 0) return;
            // 停止动画
            [self.gifView stopAnimating];
            // 设置当前需要显示的图片
            NSUInteger index =  images.count * pullingPercent;
            if (index >= images.count) index = images.count - 1;
            self.gifView.image = images[index];
        }
        
    }
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    [self updatePullRefreshFrame];
}

- (void)updatePullRefreshStateLabel {

}

- (void)updatePullRefreshFrame {
   
    if (_stateImages.count > 0) {
        if (self.hasAd) {
            [self updateLoadingPanelRefreshFrame];

        } else {
            [self updateImageGifPullRefreshFrame];

        }
    } else {
        [self updateLoadingPanelRefreshFrame];
    }

}

- (void)updateLoadingPanelRefreshFrame {
//    self.backImageView.frame = self.bounds;
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.loadingPanel.mj_y = self.mj_h/2.0f - self.loadingPanel.mj_h + 5;
    } else {
        self.lastUpdatedTimeLabel.hidden = YES;
        if (self.labelStateStyle == PullRefreshStateStyleRight) {
            self.stateLabel.hidden = NO;
            if (self.stateLabel.text.length > 0) {
                self.stateLabel.mj_h = 20.f;
                [self.stateLabel sizeToFit];
                self.stateLabel.mj_x = self.mj_w * 0.5 - 15;
                self.loadingPanel.mj_y = self.mj_h/2.0f - self.loadingPanel.mj_h + 5;
                self.loadingPanel.mj_x = self.stateLabel.mj_x - self.labelLeftInset - self.loadingPanel.mj_w;
                self.stateLabel.mj_y = self.loadingPanel.mj_y - 5;
            } else {
                self.loadingPanel.mj_y = self.mj_h/2.0f - self.loadingPanel.mj_h + 5;
            }
           
        } else if (self.labelStateStyle == PullRefreshStateStyleBottom) {
            self.stateLabel.hidden = NO;
            if (self.stateLabel.text.length > 0) {
                self.stateLabel.mj_h = 20.f;
                if (self.hasAd) {
                    self.loadingPanel.mj_y = self.mj_h/2.0f - self.loadingPanel.mj_h - 5;
                    self.stateLabel.mj_y = CGRectGetMaxY(self.loadingPanel.frame) + 10;
                } else {
                    self.loadingPanel.mj_y = self.mj_h/2.0f - self.loadingPanel.mj_h - 5;
                    self.stateLabel.mj_y = CGRectGetMaxY(self.loadingPanel.frame) + 10;
                }
            } else {
                if (self.refreshHeight == 0) {
                    self.loadingPanel.mj_y = self.mj_h/2.0f - self.loadingPanel.mj_h + 5;

                } else {
                    self.loadingPanel.mj_y = 32 + self.mj_h/2.0f - self.loadingPanel.mj_h + 5;

                }
            }
            
        } else {
            self.loadingPanel.mj_y = self.mj_h/2.0f - self.loadingPanel.mj_h + 5;
            self.stateLabel.hidden = YES;
        }
    }
}

- (void)updateImageGifPullRefreshFrame {
//    self.backImageView.frame = self.bounds;

    if (self.gifView.constraints.count) return;
    
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifView.frame = self.bounds;
        self.gifView.contentMode = UIViewContentModeCenter | UIViewContentModeBottom;
    } else {
        self.lastUpdatedTimeLabel.hidden = YES;
        if (self.labelStateStyle == PullRefreshStateStyleRight) {
            self.stateLabel.hidden = NO;
            CGFloat stateWidth = self.stateLabel.mj_textWith;
            self.gifView.frame = self.bounds;
            self.gifView.contentMode = UIViewContentModeRight;
            CGFloat timeWidth = 0.0;
            if (!self.lastUpdatedTimeLabel.hidden) {
                timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
            }
            CGFloat textWidth = MAX(stateWidth, timeWidth);
            self.gifView.mj_w = self.mj_w * 0.5 - textWidth * 0.5 - self.labelLeftInset;
            
        } else if (self.labelStateStyle == PullRefreshStateStyleBottom) {
            self.stateLabel.hidden = NO;
            if (self.stateLabel.text.length == 0) {
                self.gifView.frame = self.bounds;
                self.gifView.contentMode = UIViewContentModeCenter | UIViewContentModeBottom;
            } else {
                self.stateLabel.mj_h = 20.f;
                if (self.hasAd) {
                    self.gifView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 10, self.bounds.size.width, self.bounds.size.height - 30.f - CGRectGetHeight(self.stateLabel.bounds));
                    self.gifView.contentMode = UIViewContentModeCenter | UIViewContentModeScaleAspectFit;
                    self.gifView.clipsToBounds = YES;
                    self.stateLabel.mj_y = CGRectGetMaxY(self.gifView.frame);
                } else {
                    self.gifView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 5, self.bounds.size.width, self.bounds.size.height - CGRectGetHeight(self.stateLabel.bounds));
                    self.gifView.contentMode = UIViewContentModeCenter;
                    self.gifView.clipsToBounds = YES;
                    self.stateLabel.mj_y = CGRectGetMaxY(self.gifView.frame) - 10;
                }
                
            }
            
        } else {
            if (self.refreshHeight == 0) {
                self.stateLabel.hidden = YES;
                self.gifView.frame = self.bounds;
                self.gifView.contentMode = UIViewContentModeCenter | UIViewContentModeBottom;
            } else {
                self.stateLabel.hidden = YES;
                self.gifView.frame = self.bounds;
                self.gifView.contentMode = UIViewContentModeCenter;
            }
            
        }
    }
    
}


-(void)backImage:(NSString *)backImageUrlString
{

}

- (void)dealRefreshAd {
    
}

- (void)removeRefreshAd
{
    self.backImageView.image = nil;
}

-(void)setHasAd:(BOOL)hasAd {
    _hasAd = hasAd;
    if (hasAd) {
        self.loadingPanel.hidden = NO;
        self.gifView.hidden = YES;
        self.mj_h = self.refreshHeight == 0 ? MJRefreshHeaderHeight : self.refreshHeight;
    } else {
        self.gifView.hidden = NO;
        self.loadingPanel.hidden = YES;
        self.mj_h = self.refreshHeight == 0 ? MJRefreshHeaderHeightNoneAd : self.refreshHeight - 20;
    }
    if (_stateImages.count != 0) {
        if (!hasAd) {
            self.loadingPanel.refreshHeader = self.mj_h;
        }
    }
}

-(void)setRefreshHeight:(CGFloat)refreshHeight {
    _refreshHeight = refreshHeight;
    if (self.hasAd) {
        self.loadingPanel.hidden = NO;
        self.mj_h = self.refreshHeight == 0 ? MJRefreshHeaderHeight : self.refreshHeight;
    } else {
        self.loadingPanel.hidden = YES;
        self.mj_h = self.refreshHeight == 0 ? MJRefreshHeaderHeightNoneAd : self.refreshHeight - 20;
    }
    UIImage *image = self.backImageView.image;
    if (image) {
        self.backImageView.mj_y = self.mj_h - image.size.height;
    }
    
    if (_stateImages.count != 0) {
        if (!self.hasAd) {
            self.loadingPanel.refreshHeader = self.mj_h;
        }
    }
    [self updatePullRefreshFrame];

}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    if (_stateImages.count > 0) {
        if (self.hasAd) {
            [self loadingPanelOffsetDidChange];
        } else {
            [super scrollViewContentOffsetDidChange:change];
        }
    } else {
        [self loadingPanelOffsetDidChange];
    }
    
}

- (void)loadingPanelOffsetDidChange{
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        if (self.window == nil) return;

        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;

    if (self.scrollView.isDragging) { // 如果正在拖拽
        CGFloat pullDownOffset = 0;
        if (self.refreshHeight == 0) {
            pullDownOffset = MIN(ABS(offsetY), self.mj_h) - 40;
        } else {
            pullDownOffset = MIN(ABS(offsetY), self.mj_h) - 100;
        }        
        self.loadingPanel.offsetY = pullDownOffset;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    }

}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    if (_stateImages.count > 0) {
        if (self.hasAd) {
            [self loadingPanelState:state];

        } else {
            [self gifImageState:state];

        }
    } else {
        [self loadingPanelState:state];
    }
    
}

- (void)gifImageState:(MJRefreshState)state {
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateIdle) {
        
        [self.gifView stopAnimating];
    }

}

- (void)gifViewReStartAnimation {
    if (self.state == MJRefreshStateRefreshing) {
        [self.gifView startAnimating];
    }
}

- (void)loadingPanelState:(MJRefreshState)state {
    if (state == MJRefreshStateRefreshing) {
        [self.loadingPanel doAnimation];
    } else if (state == MJRefreshStateIdle) {
        [self.loadingPanel stopAnimation];
    }
}

- (void)removeLoadingPanelCircles {
    __weak __typeof__(self) weakSelf = self;
    if (self.state == MJRefreshStateIdle) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.loadingPanel removeAllCircles];
        });
    }
}

- (BOOL)isLoadingPanelAnimation {
    return self.loadingPanel.isCircleAnimation;
}

- (void)reStartAnimation {
    [self.loadingPanel doAnimation];

}

- (void)doAutoRefreshloadingPanel {
    [self.loadingPanel doAutoPullDown];
}

@end
