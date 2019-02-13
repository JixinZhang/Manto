//
//  ZARPCNetworkConfig.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZARPCBaseRequest;

/**
 处理URL的拼接
 */
@protocol B5MUrlFilterProtocol <NSObject>

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(ZARPCBaseRequest *)request;

@end

/**
 domain映射为IP
 */
@protocol ZARPCRequestDomainProtocol <NSObject>

- (NSString *)ipHostUrlWithUrl:(NSString *)domainUrl;

@end

/**
 处理公共头部信息
 */
@protocol ZARPCRequestHeaderProtocol <NSObject>

- (NSDictionary *)requestHeaderDictionary:(NSDictionary *)dictionary withRequest:(ZARPCBaseRequest *)request;

@end

/**
 特殊错误的处理
 */
@protocol ZARPFailedResponseProtocol <NSObject>

- (BOOL)doWithFailedRequest:(ZARPCBaseRequest *)request;

@end

@interface ZARPCNetworkConfig : NSObject

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *cdnUrl;
@property (nonatomic, strong, readonly) NSArray *urlFilters;
@property (nonatomic, strong, readonly) NSArray *headerFilters;
@property (nonatomic, strong, readonly) NSArray *failedFilters;

@property (nonatomic, strong) id<ZARPCRequestDomainProtocol> domainFilter;

+ (ZARPCNetworkConfig *)sharedInstance;

- (void)addUrlFilters:(id<B5MUrlFilterProtocol>)filter;

- (void)addRequestHeaders:(id<ZARPCRequestHeaderProtocol>)filter;

- (void)addFailedResponseFilter:(id<ZARPFailedResponseProtocol>)filter;

@end

