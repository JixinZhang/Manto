//
//  BGMicroApplicationDelegate.h
//  MobileFramework
//
//  Created by micker on 15/5/14.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>

@class BGMicroApplication;

@protocol BGMicroApplicationDelegate <NSObject>
@required

- (UIViewController *) rootViewControllerInApplication:(BGMicroApplication *) application;

@optional

- (void) applicationDidCreate:(BGMicroApplication *) application;

- (void) application:(BGMicroApplication *) application willStartLaunchingWithOptions:(NSDictionary *) options;

- (void) applicationDidFinishLaunching:(BGMicroApplication *) application;

- (void) applicationWillPause:(BGMicroApplication *) application;

- (void) application:(BGMicroApplication *) application willResumeWithOptions:(NSDictionary *) options;

- (void) applicationDidResume:(BGMicroApplication *) application;

- (void) application:(BGMicroApplication *) application didResumeWithOptions:(NSDictionary *) options;

- (void) applicationWillTerminate:(BGMicroApplication *) application animated:(BOOL) animated;

- (BOOL) applicationShoulBGerminated:(BGMicroApplication *) application;

- (BOOL) applicationShouldStartRootViewControllerWithAnimated:(BGMicroApplication *) application;
@end
