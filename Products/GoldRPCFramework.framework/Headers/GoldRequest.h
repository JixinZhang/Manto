//
//  GoldRequest.h
//  B5MRPCFramework
//
//  Created by micker on 15/12/1.
//  Copyright © 2015年 Micker. All rights reserved.
//

#import "GoldBaseRequest.h"


typedef NS_ENUM(NSInteger , GOLD_REQUEST_CACHE_TYPE) {
    GOLD_REQUEST_CACHE_REMOTE_ONLY = 0,
    GOLD_REQUEST_CACHE_DISK_OR_REMOTE,
    GOLD_REQUEST_CACHE_DISK_AND_REMOTE
};

typedef void(^GoldRequestNoParamsBlock)();


@interface GoldRequest : GoldBaseRequest

@property (nonatomic, assign) GOLD_REQUEST_CACHE_TYPE cacheType;
@property (nonatomic, assign) NSInteger cacheTimeInSeconds; // For subclass to overwrite, default is one day 86400
@property (nonatomic, copy) void (^cacheCompletionBlock)(GoldBaseRequest *);

// 直接从当前缓存中获取数据，并执行回调，若无，则未回调
- (BOOL) loadDataFromCache;

/// 返回当前缓存的对象
- (id)cacheJson;

/// 是否当前的数据从缓存获得
- (BOOL)isDataFromCache;

/// 返回是否当前缓存需要更新
- (BOOL)isCacheVersionExpired;

/// 强制更新缓存
- (void)startWithoutCache;

/// 手动将其他请求的JsonResponse写入该请求的缓存
- (void)saveJsonResponseToCacheFile:(id)jsonResponse;


- (long long)cacheVersion;

- (id)cacheSensitiveData;

- (int) intervalAfterLastUpdate;


/**
 Remove curretn request from cache
 */
- (void) clearCache;

/**
 * Get the size used by the disk cache
 */
+ (NSUInteger) getSize;

/**
 * Remove all cached request from disk
 * @see cleanDiskWithCompletionBlock:
 */
+ (void) clearDisk;

/**
 * Clear all disk cached responses. Non-blocking method - returns immediately.
 * @param completion    An block that should be executed after cache expiration completes (optional)
 */
+ (void) clearDiskOnCompletion:(GoldRequestNoParamsBlock) completion;

@end
