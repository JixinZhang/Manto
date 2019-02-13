//
//  ZARPCNetworkConfig.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCNetworkConfig.h"

@implementation ZARPCNetworkConfig {
    NSMutableArray *_urlFilters;
    NSMutableArray *_requestHeaderFilters;
    NSMutableArray *_failedResponseFilters;
}

+ (ZARPCNetworkConfig *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ZARPCNetworkConfig alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _urlFilters = [NSMutableArray array];
        _requestHeaderFilters = [NSMutableArray array];
        _failedResponseFilters = [NSMutableArray array];
    }
    return self;
}

- (void)addUrlFilters:(id<B5MUrlFilterProtocol>)filter {
    [_urlFilters addObject:filter];
}

- (void)addRequestHeaders:(id<ZARPCRequestHeaderProtocol>)filter {
    [_requestHeaderFilters addObject:filter];
}

- (void)addFailedResponseFilter:(id<ZARPFailedResponseProtocol>)filter {
    [_failedResponseFilters addObject:filter];
}

- (NSArray *)urlFilters {
    return [_urlFilters copy];
}

- (NSArray *)headerFilters {
    return [_requestHeaderFilters copy];
}

- (NSArray *)failedFilters {
    return [_failedResponseFilters copy];
}


@end
