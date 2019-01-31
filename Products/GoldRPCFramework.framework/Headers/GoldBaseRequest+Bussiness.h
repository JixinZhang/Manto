//
//  GoldBaseRequest+Response.h
//  GoldRPCFramework
//
//  Created by hushaohua on 12/13/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import "GoldBaseRequest.h"

//{
//    "code": 200,
//    "message": "Success",
//    "data": { <-----
//    }
//}

@class GoldErrorResponse;
@protocol GoldBaseRequestBussinessDelegate <NSObject>

@optional
- (BOOL) requestBussinessSuccess:(GoldBaseRequest *)request;
- (id) responseBussinessDataForRequest:(GoldBaseRequest *)request;
- (GoldErrorResponse *) bussinessErrorForRequest:(GoldBaseRequest *)request;

@end

@interface GoldBaseRequest (Bussiness)

@property(nonatomic, class, weak) id<GoldBaseRequestBussinessDelegate> classBussinessDelegate;


- (id) responseBussinessData;

// checkout bussiness success,是否符合业务成功，若不需要检测，直接返回YES
// default:YES
- (BOOL) checkBussinessSuccess;

@end
