//
//  BGClientDelegate+TouTiao.m
//  TouTiao
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "BGClientDelegate+TouTiao.h"
#import <AVFoundation/AVFoundation.h>

@implementation BGClientDelegate (TouTiao)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL flag = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MRouter sharedRouter] handleURL:url userInfo:nil useDefault:flag];
    });
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    DEBUGLOG(@"内存警告了⚠️⚠️⚠️⚠️⚠️⚠️⚠️");
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[SDImageCache sharedImageCache] clearMemory];
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL flag = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MRouter sharedRouter] handleURL:url userInfo:nil useDefault:flag];
    });
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler {
    
}

/* 3D Touch回调方法 */
- (void)application:(UIApplication *)application
performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler {
    NSDictionary *shortcutItemDict = @{@"self_AStock":@"wscn://wallstreetcn.com/markets/home",
                                       @"RealTimeNews":@"https://wallstreetcn.com/live",
                                       @"Premium":@"http://wallstreetcn.com/premium",
                                       @"Search":@"https://wallstreetcn.com/search"};
    NSDictionary *shortcutEventDict = @{@"self_AStock":@"自选行情",
                                        @"RealTimeNews":@"实时快讯",
                                        @"Premium":@"付费精选",
                                        @"Search":@"快捷搜索"};
    if (![[shortcutItemDict allKeys] containsObject:shortcutItem.type]) {
        return;
    }
    NSString *url = [shortcutItemDict stringValueForKey:shortcutItem.type];
//    [[BGServiceManager defaultUBAService] noteEvent:@"3D_Touch" userInfo:@{@"components":[shortcutEventDict stringValueForKey:shortcutItem.type]}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[MRouter sharedRouter] handleURL:[NSURL URLWithString:url] userInfo:nil];
        
    });
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings  {
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0) {
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString* deviceTokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                    stringByReplacingOccurrencesOfString: @">" withString: @""]
                                   stringByReplacingOccurrencesOfString: @" " withString: @""];
    //    [UMessage removeAllTags:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
    //        if (error) {
    //
    //        }
    //    }];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    [self receiveNotification:userInfo completionHandler:completionHandler];
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}

#pragma mark - user activity

- (BOOL) application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType{
    return YES;
}

- (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        [self performHandleBlock:^{
            [[MRouter sharedRouter] handleURL:userActivity.webpageURL userInfo:nil];
        } afterDelay:0.4];
    }
    return YES;
}

- (void) application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error{
    
}

- (void) application:(UIApplication *)application didUpdateUserActivity:(nonnull NSUserActivity *)userActivity{
    
}

#pragma mark - Private

//- (void)receiveNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
//    NSString *typeStr = [userInfo objectForKey:@"type"];
//    if (![typeStr isKindOfClass:[NSNull class]] && [typeStr isEqualToString:@"delete"]) {
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    }else {
//        if ([userInfo objectForKey:@"aps"]) {
//            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
//                PushAssist *pushAssistManager = [PushAssist sharedAssist];
//                [pushAssistManager receiectMainNewsNotificationWithUserInfo:userInfo];
//            }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
//                if (![userInfo isKindOfClass:[NSDictionary class]]) {
//                    return;
//                }
//                if ([userInfo valueForKey:@"uri"]){
//                    NSString* url = [userInfo valueForKey:@"uri"];
//                    [PushAssist openNotificationMessageWithUri:url];
//                    NSString* vip_url = [userInfo stringValueForKey:@"vip_uri"];
//                    if (vip_url.length) {
//                        url = vip_url;
//                    }
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"KOPENUSERPUSHNOTIFICATION" object:nil userInfo:nil];
//                    [self performHandleBlock:^{
//                        [[MRouter sharedRouter] handleURL:[NSURL URLWithString:url] userInfo:nil];
//                    } afterDelay:0.4];
//                }
//            }
//        }
//    }
//}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    UIViewController *currentViewController = [self topViewController:window];
    if (!window) {
        currentViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL rotateSelector = NSSelectorFromString(@"canAutoRotate");
    if ([currentViewController respondsToSelector:rotateSelector]) {
        NSMethodSignature *signature = [currentViewController methodSignatureForSelector:rotateSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:rotateSelector];
        [invocation setTarget:currentViewController];
        [invocation invoke];
        BOOL canAutorotate = NO;
        [invocation getReturnValue:&canAutorotate];
        if (canAutorotate) {
            SEL supportedOrientationsSelector = NSSelectorFromString(@"currentSupportedInterfaceOrientations");
            if ([currentViewController respondsToSelector:supportedOrientationsSelector]) {
                NSMethodSignature *signatureInterface = [currentViewController methodSignatureForSelector:supportedOrientationsSelector];
                NSInvocation *invocationInterface = [NSInvocation invocationWithMethodSignature:signatureInterface];
                [invocationInterface setSelector:supportedOrientationsSelector];
                [invocationInterface setTarget:currentViewController];
                [invocationInterface invoke];
                //返回值长度
                NSUInteger length = [signatureInterface methodReturnLength];
                //根据长度申请内存
                void *buffer = (void *)malloc(length);
                //为变量赋值
                [invocationInterface getReturnValue:buffer];
                return [[NSNumber numberWithInteger:*((NSInteger*)buffer)] integerValue];
                
            } else {
                return UIInterfaceOrientationMaskAllButUpsideDown;
            }
        }
    }
#pragma clang diagnostic pop
    
    return ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait && kDevice_Is_EnableRotate) ? UIInterfaceOrientationMaskAllButUpsideDown:
    UIInterfaceOrientationMaskPortrait;
}


- (UIViewController *)topViewController:(UIWindow *)window {
    return [self topViewControllerWithRootViewController:window.rootViewController];
}

- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply {
}

@end
