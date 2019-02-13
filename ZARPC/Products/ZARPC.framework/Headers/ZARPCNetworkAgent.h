//
//  ZARPCNetworkAgent.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZARPCBaseRequest;

NS_ASSUME_NONNULL_BEGIN

@interface ZARPCNetworkAgent : NSObject

+ (ZARPCNetworkAgent *)sharedInstance;

+ (ZARPCNetworkAgent *)agentWithConfiguration:(NSURLSessionConfiguration *)configuration;

- (void)enableLog:(BOOL)enable;

- (void)addRequest:(ZARPCBaseRequest *)request;

- (void)cancelRequest:(ZARPCBaseRequest *)request;

- (void)cancelAllRequest;

- (NSString *)buildRequestUrl:(ZARPCBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
