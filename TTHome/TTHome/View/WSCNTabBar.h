//
//  WSCNTabBar.h
//  MHomeFramework
//
//  Created by AlexZhang on 2018/12/5.
//  Copyright © 2018 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 WSCNTabBarDelgate
 当WSCNTabBar 的某一个TabBarItem点击之后 触发 - (void)wscnTabBarDidSelectedAtIndex:(NSInteger)index;
 */
@protocol WSCNTabBarDelegate <NSObject>

- (void)wscnTabBarDidSelectedAtIndex:(NSInteger)index;

@end

@interface WSCNTabBar : UITabBar

@property (nonatomic, readonly) NSArray *tabBarItemArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak) UITabBarController *tabBarController;
@property (nonatomic, weak) id<WSCNTabBarDelegate> wscnDelegate;

- (void)setTabBarWithWithDatas:(NSArray *)datas;

/**
 添加小红点

 @param index 需要添加的TabBarItem对应的index
 */
- (void)addBadgeViewWithTabbarIndex:(NSInteger)index;

/**
 移除小红点

 @param index 需要移除的TabBarItem对应的index
 */
- (void)removeBageViewWithTabbarIndex:(NSInteger)index;

@end
