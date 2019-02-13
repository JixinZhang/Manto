//
//  ZARPCTrafficMonitor.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define M_GT_K_B 1000.0
#define M_GT_KB 1024.0
#define M_GT_MB (1024.0 * M_GT_KB)
#define M_GT_GB (1024.0 * M_GT_MB)

#define M_GT_SIZE_32        32
#define M_GT_SIZE_64        64
#define M_GT_SIZE_128       128
#define M_GT_SIZE_256       256
#define M_GT_SIZE_1024      1024

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZARPCTrafficMonitorNetStatues) {
    ZARPCTrafficMonitorNetStatuesNotReachable = 0,
    ZARPCTrafficMonitorNetStatuesReachableViaWiFi,
    ZARPCTrafficMonitorNetStatuesReachableViaWWAN
};

@interface ZARPCTrafficMonitor : NSObject
{
    SCNetworkReachabilityRef _reachability;
    SCNetworkReachabilityContext _context;
    ZARPCTrafficMonitorNetStatues _networkStatus;
    
    NSTimeInterval      _date;
    
    BOOL         _prevValid;
    int64_t      _prevWiFiSent;
    int64_t      _prevWiFiReceived;
    int64_t      _prevWWANSent;
    int64_t      _prevWWANReceived;
    
    int64_t      _WiFiSent;
    int64_t      _WiFiReceived;
    int64_t      _WWANSent;
    int64_t      _WWANReceived;
    
    char         _netInfo[128];   //记录上一次的数据，对于NET历史数据，只保存变化的，如果没有变化，历史数据不保存
    BOOL         _newRecord; //标识是否为新记录，判断新记录的标准为当前netInfo是否和之前的netInfo有变化
}

@property (nonatomic) ZARPCTrafficMonitorNetStatues netStatus;

@property (nonatomic, assign) NSTimeInterval  date;

@property (nonatomic, readonly) int64_t prevWiFiSent;
@property (nonatomic, readonly) int64_t prevWiFiReceived;
@property (nonatomic, readonly) int64_t prevWWANSent;
@property (nonatomic, readonly) int64_t prevWWANReceived;

@property (nonatomic, readonly) int64_t WiFiSent;
@property (nonatomic, readonly) int64_t WiFiReceived;
@property (nonatomic, readonly) int64_t WWANSent;
@property (nonatomic, readonly) int64_t WWANReceived;

+ (instancetype)sharedInstance;

- (void)updateNetData;
- (void)resetData;
- (ZARPCTrafficMonitorNetStatues)currentNetStatus;

@end

NS_ASSUME_NONNULL_END
