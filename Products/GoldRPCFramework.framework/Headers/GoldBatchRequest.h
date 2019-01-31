//
//  GoldBatchRequest.h
//  GoldRPCFramework
//
//  Created by Micker on 2017/8/16.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoldBaseRequest.h"


/**
 批量处理接口回调
 */
@interface GoldBatchRequest : NSObject

@property (nonatomic) NSInteger tag;

@property (nonatomic, strong, readonly) NSArray<GoldBaseRequest *> *requestArray;

@property (nonatomic, copy) void (^completionBlock)(GoldBatchRequest *);

- (instancetype)initWithRequestArray:(NSArray<GoldBaseRequest *> *)requestArray;

+ (instancetype)batchRequestArray:(NSArray<GoldBaseRequest *> *)requestArray;

- (void)start;

- (void)stop;

@end
