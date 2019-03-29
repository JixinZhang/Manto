//
//  TouTiaoOnStartServiceImpl.m
//  TouTiao
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TouTiaoOnStartServiceImpl.h"
#import "GoldLog+Mars.h"

@implementation TouTiaoOnStartServiceImpl

- (void)didCreate {
    
}

- (void)start {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self __configCache];
        [self __configTimer];
        [self __configCookie];
        [self __configDB];
        [self configTestDebugExchange];
        [self changeLNRefreshHeaderAnimationType];
    });
    
    [[BGTaskDispatcher taskDefault] addTaskIdentifier:@"__configRouter" task:^{
        [self __configRouter];
    }];
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id) __configCache {
    int cacheSizeMemory = 50*1024*1024; // 50MB
    int cacheSizeDisk = 400*1024*1024; // 400MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory
                                                            diskCapacity:cacheSizeDisk
                                                                diskPath:@"urlCache"];
    [NSURLCache setSharedURLCache:sharedCache];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    return self;
}

- (id) __configRouter {
    
    [MRouter sharedRouter].routerHandler  = ^(NSURL *originURL) {
        if ([originURL.scheme isEqualToString:@"wscn"]) {
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"https", [originURL.absoluteString substringFromIndex:4]]];
        }
        return originURL;
    };
    [[MRouter sharedRouter] start];
    return self;
}

- (id) __configTheme {
    
    return self;
}


- (id) __configTimer {
    return self;
}

- (id) __configDB {
//    DEBUGLOG(@"本地数据库地址 = %@", [[GoldDataOperateCenter sharedInstance] databasePath]);
    return self;
}

- (id) __printCurrentLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    DEBUGLOG(@"当前系统的语言设置为：%@",currentLanguage);
    return self;
}


- (id) __configCookie {
    
    return self;
}

- (void)handlePushMessageRoute:(NSString *)url {
    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:url] userInfo:nil];
    
}

- (void)configTestDebugExchange {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignUserNotification:) name:@"MDEBUG_ENVIRONMENT_STATUS_CHANGED_NOTIFICATION" object:nil];
}

- (void)uploadTrafficMonitorResults {
#ifdef DEBUG
    ZARPCTrafficMonitor *trafficMonitor = [ZARPCTrafficMonitor sharedInstance];
    [trafficMonitor updateNetData];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:trafficMonitor.date];
    NSDate *endDate = [NSDate date];
    long long WWANSent = trafficMonitor.WWANSent;
    long long WWANReceived = trafficMonitor.WWANReceived;
    
    NSString *trafficMonitorMessage = [NSString stringWithFormat:@"\n\nZARPCTrafficMonitor \nWi-Fi S:%@ \t R:%@ \r\nWWAN S:%@ \t R:%@ \n\n", [ZARPCContentLengthUtils getUnitFormatedFileSizeWithContentLength:[trafficMonitor WiFiSent]], [ZARPCContentLengthUtils getUnitFormatedFileSizeWithContentLength:[trafficMonitor WiFiReceived]], [ZARPCContentLengthUtils getUnitFormatedFileSizeWithContentLength:[trafficMonitor WWANSent]], [ZARPCContentLengthUtils getUnitFormatedFileSizeWithContentLength:[trafficMonitor WWANReceived]]];
    DEBUGLOG(@"%@", trafficMonitorMessage);
#endif
    
}

#pragma mark --
#pragma mark --NSNotification
- (void) appWillTernimated:(NSNotification *) notification {
    [self uploadTrafficMonitorResults];
    [GoldLog endMarsLog];
}

- (void)enterForegroundNotification:(NSNotification *) norification {
    ZARPCTrafficMonitor *trafficMonitor = [ZARPCTrafficMonitor sharedInstance];
    [trafficMonitor updateNetData];
}

- (void)changeLNRefreshHeaderAnimationType {
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i < 16; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [idleImages addObject:image];
    }
    [LNRefreshHandler setAllHeaderAnimatorStateImages:idleImages state:LNRefreshState_Normal];
    [LNRefreshHandler setAllHeaderAnimatorStateImages:idleImages state:LNRefreshState_Refreshing];
    [LNRefreshHandler changeAllHeaderAnimatorType:LNRefreshHeaderType_GIF bgImage:nil incremental:60];
    
}

@end
