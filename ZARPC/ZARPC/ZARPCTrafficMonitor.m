//
//  ZARPCTrafficMonitor.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCTrafficMonitor.h"
#import <ifaddrs.h>
#import <sys/socket.h>
#import <net/if.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <sys/mman.h>
#import <mach/mach.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@implementation ZARPCTrafficMonitor

@synthesize netStatus = _networkStatus;

@synthesize date = _date;
@synthesize prevWiFiSent = _prevWiFiSent;
@synthesize prevWiFiReceived = _prevWiFiReceived;
@synthesize prevWWANSent = _prevWWANSent;
@synthesize prevWWANReceived = _prevWWANReceived;
@synthesize WiFiSent = _WiFiSent;
@synthesize WiFiReceived = _WiFiReceived;
@synthesize WWANSent = _WWANSent;
@synthesize WWANReceived = _WWANReceived;

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static ZARPCTrafficMonitor * trafficMonitor;
    dispatch_once( &once, ^{
        trafficMonitor = [[ZARPCTrafficMonitor alloc] init];
    });
    return trafficMonitor;
}

-(id)init {
    self = [super init];
    if (self) {
        _prevValid        = false;
        _prevWiFiSent     = 0;
        _prevWiFiReceived = 0;
        _prevWWANSent     = 0;
        _prevWWANReceived = 0;
        
        _WiFiSent     = 0;
        _WiFiReceived = 0;
        _WWANSent     = 0;
        _WWANReceived = 0;
        _networkStatus = [self currentNetStatus];
        memset(_netInfo, 0, sizeof(_netInfo));
        
        _date = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

-(void)dealloc {
    
}

- (ZARPCTrafficMonitorNetStatues) currentNetStatus {
    _networkStatus = ZARPCTrafficMonitorNetStatuesNotReachable;
    SCNetworkReachabilityFlags flags;
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    _reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    
    if (SCNetworkReachabilityGetFlags(_reachability, &flags))
    {
        [self updateNetworkStatusForFlags:flags];
    }
    
    if (_reachability != NULL) {
        CFRelease(_reachability);
    }
    
    return _networkStatus;
}

- (void)updateNetData {
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    int64_t WiFiSent = 0;
    int64_t WiFiReceived = 0;
    int64_t WWANSent = 0;
    int64_t WWANReceived = 0;
    
    success = getifaddrs(&addrs) == 0;
    
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if (strcmp(cursor->ifa_name, "en0") == 0)
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                }
                if (strcmp(cursor->ifa_name, "pdp_ip0") == 0)
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    
    if (_prevValid == true) {
        _WiFiSent = WiFiSent - _prevWiFiSent;
        _WiFiReceived = WiFiReceived - _prevWiFiReceived;
        _WWANSent = WWANSent - _prevWWANSent;
        _WWANReceived = WWANReceived - _prevWWANReceived;
        
    } else {
        //记录第一次启动监控的流量
        _prevValid = true;
        _prevWiFiSent = WiFiSent;
        _prevWiFiReceived = WiFiReceived;
        _prevWWANSent = WWANSent;
        _prevWWANReceived = WWANReceived;
    }
    
    char info[M_GT_SIZE_128] = {0};
    memset(info, 0, M_GT_SIZE_128);
    snprintf(info, M_GT_SIZE_128 - 1, "Wifi T:%.3fKB R:%.3fKB\rWWAN T:%.3fKB R:%.3fKB", _WiFiSent/M_GT_K_B,_WiFiReceived/M_GT_K_B,_WWANSent/M_GT_K_B,_WWANReceived/M_GT_K_B);
    
    //    NSString *netInfo = [NSString stringWithFormat:@"Wifi T:%.3fKB R:%.3fKB\rWWAN T:%.3fKB R:%.3fKB",_WiFiSent/M_GT_K_B,_WiFiReceived/M_GT_K_B,_WWANSent/M_GT_K_B,_WWANReceived/M_GT_K_B];
    
    
    //和之前的信息对比判断是否有变化
    if (!strcmp(_netInfo, info)) {
        _newRecord = NO;
    } else {
        _newRecord = YES;
        memset(_netInfo, 0, sizeof(_netInfo));
        //记录本次信息，用于下次采集时判断是否有变化
        memcpy(_netInfo, info, sizeof(info));
    }
    
    return;
}

- (void)resetData {
    _prevValid = false;
    _prevWiFiSent = 0;
    _prevWiFiReceived = 0;
    _prevWWANSent = 0;
    _prevWWANReceived = 0;
    
    _WiFiSent     = 0;
    _WiFiReceived = 0;
    _WWANSent     = 0;
    _WWANReceived = 0;
    [self updateNetData];
}

// 更新网络状态
- (void)updateNetworkStatusForFlags:(SCNetworkReachabilityFlags)flags {
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        _networkStatus = ZARPCTrafficMonitorNetStatuesNotReachable;
        return;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        _networkStatus = ZARPCTrafficMonitorNetStatuesReachableViaWiFi;
    }
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            _networkStatus = ZARPCTrafficMonitorNetStatuesReachableViaWiFi;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        _networkStatus = ZARPCTrafficMonitorNetStatuesReachableViaWWAN;
    }
    return;
}
@end
