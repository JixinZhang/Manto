//
//  BGMicroApplication.h
//  MobileFramework
//
//  Created by micker on 15/5/14.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGMicroApplicationDescriptor.h"
#import "BGMicroApplicationLaunchMode.h"
#import "BGMicroApplicationDelegate.h"

extern NSString * const kBGMicroApplicationDidCreateNotification;
extern NSString * const kBGMicroApplicationWillTerminateNotification;
extern NSString * const kBGMicroApplicationDoesNotFoundNotification;

@interface BGMicroApplication : NSObject

@property (nonatomic, strong) BGMicroApplicationDescriptor *descriptor;

@property (nonatomic, strong) id<BGMicroApplicationDelegate> delegate;

@property (nonatomic, assign) BGMicroApplicationLaunchMode launchMode;

- (UIViewController *) rootViewController;

- (void) exitAnimated:(BOOL) animated;

- (void) handleRemoteNotifications:(NSDictionary *) notifications;

@end


BGMicroApplication *BGMicroApplicationGetCurrent();

