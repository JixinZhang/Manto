//
//  ZARPCBaseRequest+Bussiness.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCBaseRequest+Bussiness.h"

static id<ZARPCBaseRequestBussinessDelegate> stBussinessDelegate = nil;

@implementation ZARPCBaseRequest (Bussiness)

+ (void) setClassBussinessDelegate:(id<ZARPCBaseRequestBussinessDelegate>)classDelegate{
    stBussinessDelegate = classDelegate;
}

+ (id<ZARPCBaseRequestBussinessDelegate>) classBussinessDelegate{
    return stBussinessDelegate;
}

- (id) responseBussinessData{
    return self.responseObject;
}

- (BOOL) checkBussinessSuccess{
    return YES;
}

@end
