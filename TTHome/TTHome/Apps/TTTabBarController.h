//
//  TTTabBarController.h
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TabBarItemClickedProtocol <NSObject>

- (void) tabBarItemClicked;

@end

@interface TTTabBarController : UITabBarController

@property (nonatomic, assign) NSInteger oldSelectedIndex;

- (void)setTabBarWithWithDatas:(NSArray *)datas;

- (void)addBadgeViewWithTabbarIndex:(NSInteger)index;

- (void)removeBageViewWithTabbarIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
