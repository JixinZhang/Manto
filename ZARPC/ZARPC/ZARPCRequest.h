//
//  ZARPCRequest.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <ZARPC/ZARPC.h>

typedef NS_ENUM(NSInteger, ZARPCRequestCacheType) {
    ZARPCRequestCacheTypeRemoteOnly = 0,
    ZARPCRequestCacheTypeDiskOrRemote,
    ZARPCRequestCacheTypeDiskAndRemote
};

typedef void(^ZARPCRequestNoParamsBlock)(void);

@interface ZARPCRequest : ZARPCBaseRequest

@property (nonatomic, assign) ZARPCRequestCacheType cacheType;

/**
 缓存时间，默认一天 24 * 60 * 60 = 86400s
 */
@property (nonatomic, assign) NSInteger cacheTimeInSeconds;

@property (nonatomic, copy) void (^cacheCompletionBlock)(ZARPCBaseRequest *);

/**
 直接从当前缓存中获取数据，并执行回调，并返回YES；否则未回调，并返回NO。
 */
- (BOOL)loadDataFromCache;

/**
 返回当前缓存对象
 */
- (id)cacheJson;

/**
 当前数据是否是从缓存中获得
 */
- (BOOL)isDataFromCache;

/**
 当前缓存是否需要更新

 @return 需要更新返回YES，否则NO。
 */
- (BOOL)isCacheVersionExpired;

/**
 强制更新缓存
 */
- (void)startWithoutCache;

/**
 手动i将其他请求的Json response写入该请求的缓存
 */
- (void)saveJsonResponseToCacheFile:(id)jsonResponse;

- (long long)cacheVersion;

- (id)cacheSensitiveData;

- (int) intervalAfterLastUpdate;

/**
 Remove curretn request from cache
 */
- (void) clearCache;

/**
 * 获取缓存文件的大小
 */
+ (NSUInteger) getSize;

/**
 清除所有缓存
 */
+ (void) clearDisk;

/**
 清除所有缓存
 * Clear all disk cached responses. Non-blocking method - returns immediately.
 * @param completion    An block that should be executed after cache expiration completes (optional)
 */
+ (void) clearDiskOnCompletion:(ZARPCRequestNoParamsBlock) completion;

@end


