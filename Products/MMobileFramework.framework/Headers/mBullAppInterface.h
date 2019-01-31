//
//  mBullAppInterface.h
//  MobileFramework
//
//  Created by micker on 15/5/14.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#include <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, mBullAppEventType)
{
    mBullAppEventBeforeFinishLaunching,
    mBullAppEventAfterFinishLaunching,
    mBullAppEventBeforeStartLoader,
    mBullAppEventDidReceiveRemoteNotification,
    mBullAppEventDidReceiveRemoteNotificationFetchCompletion,
    mBullAppEventDidReceiveLocalNotification,
    mBullAppEventWillResignActive,
    mBullAppEventDidEnterBackground,
    mBullAppEventDidBecomeActive,
    mBullAppEventWillTerminate,
};

@protocol mBullAppInterface <NSObject>

@required

- (NSString *) appBriefName;

- (NSString *) appBundleIdentifier;

@optional

- (id)appDelegateEvent:(mBullAppEventType)event arguments:(NSDictionary *)arguments;

@end