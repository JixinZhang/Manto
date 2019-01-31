//
//  BGMicroApplicationManager.h
//  MobileFramework
//
//  Created by micker on 15/5/15.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGMicroApplicationLaunchMode.h"
@class BGMicroApplication;


@interface BGMicroApplicationManager : NSObject
@property (nonatomic, strong) BGMicroApplication *launcherApplication;

+ (instancetype) sharedInstance;

- (void) startLauncherApplication;

- (BOOL) startApplication:(NSString *) name parames:(NSDictionary *) parames animated:(BOOL) animated;

- (BOOL) startApplication:(NSString *) name parames:(NSDictionary *) parames launchMode:(BGMicroApplicationLaunchMode) launchMode;

- (BGMicroApplication *) findApplicationByName:(NSString *) name;

- (BGMicroApplication *) currentApplication;

- (void)exitToApplication:(BGMicroApplication *) application;
@end
