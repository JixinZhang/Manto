//
//  BGBootLoader+Boot.m
//  TouTiao
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "BGBootLoader+Boot.h"
#import <MWebViewFramework/MWebViewFramework.h>
#import <ZANetwork/SDWebImageCodersManager.h>
#import <ZANetwork/SDWebImageGIFCoder.h>

@implementation BGBootLoader (Boot)

- (void)registerBooter_Boot {
#ifdef DEBUG
    NSTimeInterval begin = [NSDate date].timeIntervalSince1970;
#endif
    [self __configLog];
    [self __configTouTiaoURLProtocol];
    [self __configRPC];
    [self __configTheme];
    
    [self performSelector:@selector(__bootlater) withObject:nil afterDelay:1];
    
#ifdef DEBUG
    DEBUGLOG(@"registerBooter_Boot. time %f", [NSDate date].timeIntervalSince1970 - begin);
#endif
    
}

- (NSString *) baseUrlForEnvMode{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleVersion = [infoDictionary valueForKey:@"CFBundleVersion"];
    if (bundleVersion.integerValue % 2 == 0) {
        //bundle号为偶数，只能为正式环境
        return @"https://api.wallstreetcn.com/";
    }
    //bundle号为奇数，可以切换环境
    switch ([MDebug sharedInstance].currentEnv) {
        case MDebug_ENV_SIT:
            return @"https://is.snssdk.com/";
        case MDebug_ENV_STAGE:
            return @"https://is.snssdk.com/";
        default:
            return @"https://is.snssdk.com/";
    }
}

- (void) __bootlater {
    [self __configUA];
}

- (id) __configRPC {
#ifdef DEBUG
    [[ZARPCNetworkAgent sharedInstance] enableLog:NO ];
#endif
    [[AFNetworkReachabilityManager sharedManager] performSelector:@selector(startMonitoring) withObject:nil afterDelay:5];
    [ZARPCNetworkConfig sharedInstance].baseUrl = [self baseUrlForEnvMode];
//    ZARPCRequest.bussinessEnabled = YES;
    //    [ZARPCNetworkConfig sharedInstance].domainFilter = [[RPCDomainHandler alloc] init];
//    [[ZARPCNetworkConfig sharedInstance] addRequestHeaders:[[RPCPublicHeaders alloc] init]];
//    [[ZARPCNetworkConfig sharedInstance] addFailedResponseFilter:[[RPCFailedResponseHandler alloc] init]];
    //行情设置国际化
    DEBUGLOG(@"BASE_URL=%@",[ZARPCNetworkConfig sharedInstance].baseUrl);
    return self;
}

- (id) __configUA {
    UIWebView* webView = [UIWebView new];
    NSMutableString* userAgent = [[NSMutableString alloc] init];
    [userAgent appendString:[webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    [userAgent appendString:[NSString stringWithFormat:@" %@/%@", @"WscnApp", [[NSBundle mainBundle] appShortVersion]]];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:userAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    DEBUGLOG(@"UserAgent = %@", dictionary);
    return self;
}

- (id) __configLog{
#ifndef DEBUG
    [GoldLog startLevel:GOLD_LOG_LEVEL_TYPE_FATAL];
#else
    [[MRouter sharedRouter] enableDebug];
#endif
    return self;
}

- (void) __configTouTiaoURLProtocol {
    
}

- (id) __configTheme {
    DEBUGLOG(@"主题初始化开始");
    [[LNTheme instance] start];
    return self;
}

@end
