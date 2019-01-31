//
//  GoldNetworkAgent.h
//  B5MRPCFramework
//
//  Created bymickeron 15/11/11.
//  Copyright © 2015年 Micker All rights reserved.
//

#import <Foundation/Foundation.h>


@class GoldBaseRequest;
@interface GoldNetworkAgent : NSObject

+ (GoldNetworkAgent *)sharedInstance;

- (void) enableLog:(BOOL) enable;

- (void)addRequest:(GoldBaseRequest *)request;

- (void)cancleRequest:(GoldBaseRequest *)request;

- (void)cancelAllRequests;

- (NSString *)buildRequestUrl:(GoldBaseRequest *)request;

//+ (NSString *) ipHostUrlWithUrl:(NSString *)domainUrl;

@end
