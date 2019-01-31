//
//  HomeAppDelegate.m
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "HomeAppDelegate.h"
#import "TTTabBarController.h"
#import "TTOnTabServiceImpl.h"
#import "TTHomeTabResource.h"

@interface HomeAppDelegate ()

@property (nonatomic, strong) TTTabBarController *tabBarController;
@property (nonatomic, strong) UIViewController *rootController;

@end

@implementation HomeAppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarController = [[TTTabBarController alloc] init];
        self.rootController = self.tabBarController;
        
        NSArray *controllers = @[
                                 @"ViewController",
                                 @"ViewController",
                                 @"ViewController",
//                                 @"ViewController",
                                 @"ViewController"];
        NSMutableArray *navArray = [NSMutableArray arrayWithCapacity:5];
        [controllers enumerateObjectsUsingBlock:^(NSString *className, NSUInteger idx, BOOL * _Nonnull stop) {
            id controller = [[NSClassFromString(className) alloc] init];
            [navArray addObject:controller];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tabBarController.viewControllers = navArray;
            [self.tabBarController.delegate tabBarController:self.tabBarController didSelectViewController:navArray[0]];
        });
        
        __weak __typeof__ (self) weakSelf = self;
        [TTHomeTabResource sharedTabResource].block = ^(NSArray * _Nonnull datas) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tabBarController setTabBarWithWithDatas:datas];
            });
        };
        
        [TTHomeTabResource sharedTabResource].badgeBlock = ^(NSString *badge) {
            if (badge) {
                [weakSelf addBadgeViewWithTabbarIndex:4];
            } else {
                [weakSelf removeBadgeViewWithTabbarIndex:4];
            }
        };
        
        
        [self ln_customThemeAction:^id{
            [[TTHomeTabResource sharedTabResource] updateTabs:nil];
            return nil;
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(removeBadgeViewForMineTabbar)
                                                     name:@"KMineTaskBottonBadgeDidHideNotification"
                                                   object:nil];

    }
    return self;
}

- (void)btnClick
{
    [[BGContext sharedInstance] startApplication:@"20000004" parames:@{} animated:YES];
}

- (UIViewController *)rootViewControllerInApplication:(BGMicroApplication *)application
{
    return self.rootController;
}

- (void)addBadgeViewWithTabbarIndex:(NSUInteger) index {
    [self.tabBarController addBadgeViewWithTabbarIndex:index];
}

- (void)removeBadgeViewWithTabbarIndex:(NSUInteger) index {
    [self.tabBarController removeBageViewWithTabbarIndex:index];
}

- (void)addBadgeViewForMineTabbar {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL didShow = [userDefaults boolForKey:@"KMineTaskBottonBadgeDidShow"];
    if (didShow) {
        return;
    }
    
    [self addBadgeViewWithTabbarIndex:4];
}

- (void)removeBadgeViewForMineTabbar {
    [self removeBadgeViewWithTabbarIndex:4];
}

@end
