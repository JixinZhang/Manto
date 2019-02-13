//
//  ZARPCBaseRequest+Bussiness.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

//{
//    "code": 200,
//    "message": "Success",
//    "data": { <-----
//    }
//}

@class ZARPCErrorResponse;

@protocol ZARPCBaseRequestBussinessDelegate <NSObject>

@optional

- (BOOL)requestBussinessSuccess:(ZARPCBaseRequest *)request;

- (id)responseBussinessDataForRequest:(ZARPCBaseRequest *)request;

- (ZARPCErrorResponse *)bussinessErrorForRequest:(ZARPCBaseRequest *)request;

@end

@interface ZARPCBaseRequest (Bussiness)

@property (nonatomic, class, weak) id<ZARPCBaseRequestBussinessDelegate> classBussinessDelegate;

- (id)responseBussinessData;

/**
 checkout bussiness success,是否符合业务成功，若不需要检测，直接返回YES

 @return default:YES
 */
- (BOOL)checkBussinessSuccess;

@end

NS_ASSUME_NONNULL_END
