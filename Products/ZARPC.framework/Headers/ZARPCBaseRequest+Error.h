//
//  ZARPCBaseRequest+Error.h
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCBaseRequest.h"

@class ZARPCErrorResponse;

NS_ASSUME_NONNULL_BEGIN

@interface ZARPCBaseRequest (Error)

- (ZARPCErrorResponse *)wscnError;

- (ZARPCErrorResponse *)bussinessError;

- (ZARPCErrorResponse *)finalError;

@end

NS_ASSUME_NONNULL_END
