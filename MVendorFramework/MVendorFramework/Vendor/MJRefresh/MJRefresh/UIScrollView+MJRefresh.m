//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"
#import <objc/runtime.h>
#import "MJRefreshAutoNormalFooter.h"
#import "NWLiveRoomRefreshGifHeader.h"

@implementation NSObject (MJRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (MJRefresh)

#pragma mark - header
static const char MJRefreshHeaderKey = '\0';
- (void)setMj_header:(MJRefreshHeader *)mj_header
{
    if (mj_header != self.mj_header) {
        // 删除旧的，添加新的
        [self.mj_header removeFromSuperview];
        [self insertSubview:mj_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_header"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
                                 mj_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_header"]; // KVO
    }
}

- (MJRefreshHeader *)mj_header
{
    return objc_getAssociatedObject(self, &MJRefreshHeaderKey);
}

#pragma mark - footer
static const char MJRefreshFooterKey = '\0';
- (void)setMj_footer:(MJRefreshFooter *)mj_footer
{
    if (mj_footer != self.mj_footer) {
        // 删除旧的，添加新的
        [self.mj_footer removeFromSuperview];
        [self insertSubview:mj_footer atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"mj_footer"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshFooterKey,
                                 mj_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_footer"]; // KVO
    }
}

- (MJRefreshFooter *)mj_footer
{
    return objc_getAssociatedObject(self, &MJRefreshFooterKey);
}

#pragma mark - 过期
- (void)setFooter:(MJRefreshFooter *)footer
{
    self.mj_footer = footer;
}

- (MJRefreshFooter *)footer
{
    return self.mj_footer;
}

- (void)setHeader:(MJRefreshHeader *)header
{
    self.mj_header = header;
}

- (MJRefreshHeader *)header
{
    return self.mj_header;
}

- (void)addPullToRefreshWithHeight:(CGFloat)height actionHandler:(void (^)(void))actionHandler {
    
    if (self.mj_header && [self.mj_header isKindOfClass:[NWLiveRoomRefreshGifHeader class]]) {
        self.mj_header.refreshingBlock = actionHandler;
        NWLiveRoomRefreshGifHeader *refreshHeader =  (NWLiveRoomRefreshGifHeader *)self.mj_header;
        refreshHeader.refreshHeight = height;
        refreshHeader.lastUpdatedTimeLabel.hidden = YES;
        refreshHeader.stateLabel.hidden = NO;
        
        if (refreshHeader.stateImages.count > 0) {
            if ([self isPullDownRefresh] && ![refreshHeader.gifView isAnimating]) {
                [refreshHeader.gifView startAnimating];
            }
        } else {
            if ([self isPullDownRefresh] ) {
                [refreshHeader reStartAnimation];
            }
        }
        
        
    } else {
        NWLiveRoomRefreshGifHeader *header = [NWLiveRoomRefreshGifHeader headerWithRefreshingBlock:^{
            actionHandler();
        }];
        header.refreshHeight = height;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = NO;
        header.labelStateStyle = PullRefreshStateStyleBottom;
        header.stateLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        
        self.mj_header = header;
    }
    
}

- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler {
    
    if (self.mj_header && [self.mj_header isKindOfClass:[NWLiveRoomRefreshGifHeader class]]) {
        self.mj_header.refreshingBlock = actionHandler;
        NWLiveRoomRefreshGifHeader *refreshHeader =  (NWLiveRoomRefreshGifHeader *)self.mj_header;
        refreshHeader.lastUpdatedTimeLabel.hidden = YES;
        refreshHeader.stateLabel.hidden = NO;
        
        if (refreshHeader.stateImages.count > 0) {
            if ([self isPullDownRefresh] && ![refreshHeader.gifView isAnimating]) {
                [refreshHeader.gifView startAnimating];
            }
        } else {
            if ([self isPullDownRefresh] ) {
                [refreshHeader reStartAnimation];
            }
        }
        
        
    } else {
        NWLiveRoomRefreshGifHeader *header = [NWLiveRoomRefreshGifHeader headerWithRefreshingBlock:^{
            actionHandler();
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = NO;
        header.labelStateStyle = PullRefreshStateStyleBottom;
        header.stateLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        
        self.mj_header = header;
    }
    
}

- (void)addInfiniteScrollingWithActionHandler:(void (^)(void))actionHandler {
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        actionHandler();
    }];
    footer.stateLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
    self.mj_footer = footer;
    self.mj_footer.hidden = YES;
}

- (void)triggerPullToRefresh {
    if ([self isPullDownRefresh]) {
        return;
    }
    [(NWLiveRoomRefreshGifHeader *)self.mj_header doAutoRefreshloadingPanel];
    [self.mj_header beginRefreshing];
}

- (void) stopAnimating  {
    if ([self isPullDownRefresh] && ![self isPullUpRefresh]) {
        [self.mj_header endRefreshing];
    } else if ([self isPullUpRefresh] && ![self isPullDownRefresh]){
        [self.mj_footer endRefreshing];
    } else if (self.mj_header.state == MJRefreshStateIdle && self.mj_footer.state == MJRefreshStateIdle) {
        
    } else {
        [self.mj_footer endRefreshing];
        [self.mj_header endRefreshing];
    }
}

- (void)reStartAnimation {
    if (self.mj_header) {
        NWLiveRoomRefreshGifHeader *refreshHeader =  (NWLiveRoomRefreshGifHeader *)self.mj_header;
        [refreshHeader gifViewReStartAnimation];
    }
}

- (BOOL)isPullDownRefresh {
    return self.mj_header.state == MJRefreshStateRefreshing ||
           self.mj_header.state == MJRefreshStatePulling ||
           self.mj_header.state == MJRefreshStateWillRefresh;
}

- (BOOL)isPullUpRefresh {
    return self.mj_footer.state == MJRefreshStateRefreshing ||
           self.mj_footer.state == MJRefreshStatePulling ||
           self.mj_footer.state == MJRefreshStateWillRefresh;
}

- (void) stopAnimatingRefreshFooter{
    if (self.mj_footer.state != MJRefreshStateIdle) {
        [self.mj_footer endRefreshing];
    }
}

- (void) stopAnimatingRefreshHeader {
    if (self.mj_header.state != MJRefreshStateIdle) {
        [self.mj_header endRefreshing];
    }
}

- (void) hideRefreshFooter {
    if (!self.mj_footer.hidden) {
        self.mj_footer.hidden = YES;
    }
}
- (void) hideRefreshHeader {
    if (!self.mj_header.hidden) {
        self.mj_header.hidden = YES;
    }
}

- (void) showRefreshFooter {
    if (self.mj_footer.hidden) {
        self.mj_footer.hidden = NO;
    }
}

- (void) showRefreshHeader {
    if (self.mj_header.hidden) {
        self.mj_header.hidden = NO;
    }
}

- (void)showPullDownRefreshLoadMore:(BOOL)isNoMoreData {
    [self stopAnimatingRefreshHeader];
    if (isNoMoreData) {
        self.mj_footer.hidden = NO;
        [self.mj_footer resetNoMoreData];
    }else {
        self.mj_footer.hidden = YES;
    }
}

- (void)pullDownDealFooterWithItemCount:(NSInteger)itemCount cursor:(NSString *)cursor{
    [self stopAnimatingRefreshHeader];
    if (itemCount == 0) {
        self.mj_footer.hidden = YES;
    } else {
        self.mj_footer.hidden = NO;
        if (cursor.length > 0) {
            [self.mj_footer resetNoMoreData];
        } else {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

- (void)pullUpRefreshDealFooterWithItemCount:(NSInteger)itemCount cursor:(NSString *)cursor {
    [self stopAnimatingRefreshFooter];
    self.mj_footer.hidden = NO;
    if (itemCount > 0 && cursor.length > 0) {
        [self.mj_footer resetNoMoreData];
    } else {
        [self.mj_footer endRefreshingWithNoMoreData];
    }

}

-(void)dealPullDownRefreshStatus:(BOOL)isNoMoreData
{
    [self.mj_header endRefreshing];
    if (isNoMoreData) {
        self.mj_footer.hidden = NO;
        [self.mj_footer resetNoMoreData];
    }else {
        self.mj_footer.hidden = YES;
    }
}
//
//- (void)dealPullUpRefreshStatus:(NSInteger)count
//{
//    [self.mj_footer endRefreshing];
//    if (count < 30) {
//        [self.mj_footer endRefreshingWithNoMoreData];
//    }else {
//        [self.mj_footer resetNoMoreData];
//    }
//}

- (void) changeRefreshFooterStatus:(BOOL)isNoMoreData {
    [self stopAnimatingRefreshFooter];
    self.mj_footer.hidden = NO;
    if (isNoMoreData) {
        [self.mj_footer resetNoMoreData];
    } else {
        [self.mj_footer endRefreshingWithNoMoreData];
    }

}

#pragma mark - other
- (NSInteger)mj_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char MJRefreshReloadDataBlockKey = '\0';
- (void)setMj_reloadDataBlock:(void (^)(NSInteger))mj_reloadDataBlock
{
    [self willChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &MJRefreshReloadDataBlockKey, mj_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"mj_reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))mj_reloadDataBlock
{
    return objc_getAssociatedObject(self, &MJRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.mj_reloadDataBlock ? : self.mj_reloadDataBlock(self.mj_totalDataCount);
}
@end

@implementation UITableView (MJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (MJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}
@end
