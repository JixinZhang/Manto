//
//  GoldNetworkConfig.h
//  B5MRPCFramework
//
//  Created bymickeron 15/11/11.
//  Copyright © 2015年 Micker All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoldBaseRequest;


/**
 处理URL的拼接
 */
@protocol B5MUrlFilterProtocol <NSObject>

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(GoldBaseRequest *)request;

@end


@protocol GoldRequestDomainProtocol <NSObject>

- (NSString *) ipHostUrlWithUrl:(NSString *)domainUrl;

@end

/**
 处理公共头部信息
 */
@protocol GoldRequestHeaderProtocol <NSObject>

- (NSDictionary *)requestHeaderDictionary:(NSDictionary *)dictionary withRequest:(GoldBaseRequest *)request;

@end


/**
 特殊错误的处理，如收到50012（已经在另外一端登录），5008（非法token，需要重新登录）
 */
@protocol GoldFailedResponseProtocol <NSObject>

- (BOOL) doWithFailedRequest:(GoldBaseRequest *)request;

@end

@interface GoldNetworkConfig : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSString *cdnUrl;
@property (nonatomic, strong, readonly) NSArray *urlFilters;
@property (nonatomic, strong, readonly) NSArray *headerFilters;
@property (nonatomic, strong, readonly) NSArray *failedFilters;

@property (nonatomic, strong) id<GoldRequestDomainProtocol> domainFilter;

+ (GoldNetworkConfig *)sharedInstance;

- (void)addUrlFilters:(id<B5MUrlFilterProtocol>)filter;

- (void)addRequestHeaders:(id<GoldRequestHeaderProtocol>)filter;

- (void)addFailedResponseFilter:(id<GoldFailedResponseProtocol>)filter;

@end
