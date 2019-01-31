//
//  BGContext.h
//  MobileFramework
//
//  Created by micker on 15/5/15.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//
#import <UIKit/UIKit.h>

#import "BGMicroApplicationLaunchMode.h"
#import "BGStartApplicationHandler.h"

@class BGMicroApplicationManager;
@class BGNavigationBarDelegate;
@class BGServiceManager;

@interface BGContext : NSObject

@property (nonatomic, strong) BGMicroApplicationManager *applicationManager;

@property (nonatomic, strong) BGServiceManager *serviceManager;

@property (nonatomic, strong) BGNavigationBarDelegate *navigationBarDelegate;

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UINavigationController *navigationController;

- (void) start;

- (BOOL) startApplication:(NSString *) name parames:(NSDictionary *) parames animated:(BOOL) animated;

- (BOOL) startApplication:(NSString *) name parames:(NSDictionary *) parames launchMode:(BGMicroApplicationLaunchMode) launchMode;

- (BGMicroApplication *) findApplicationByName:(NSString *) name;

- (BGMicroApplication *) currentApplication;

- (id) findServiceByName:(NSString *) name;

- (BOOL) registerService:(id) service forName:(NSString *) name;

- (void) unRegisterServiceForName:(NSString *) name;

- (BOOL) registerStartApplicationHandler:(id<BGStartApplicationHandler>) handler;

- (void) unRegisterStartApplicationHandler:(id<BGStartApplicationHandler>) handler;

- (BOOL) beginAPPTransaction;

- (void) commitAPPTransaction;

- (NSArray *) viewControllersForApplication:(NSString *) name;

- (void) setViewControllers:(NSArray *) viewControllers forApplication:(NSString *) name animated:(BOOL) flag;

- (NSArray *) viewControllers;

+ (instancetype) sharedInstance;

@end
