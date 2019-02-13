//
//  ZARPCBaseRequest+Error.m
//  ZARPC
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ZARPCBaseRequest+Error.h"
#import "ZARPCBaseRequest+Bussiness.h"
#import "ZARPCBaseResponse.h"
#import "NSDictionary+Response.h"

@implementation ZARPCBaseRequest (Error)

- (ZARPCErrorResponse *) ivankaError{
    NSDictionary* response = self.responseObject;
    if ([response objectForKey:@"code"]){
        NSInteger code = [response integerValueForKey:@"code"];
        NSString* message = [response stringValueForKey:@"message"];
        ZARPCErrorResponse* error = [[ZARPCErrorResponse alloc] init];
        error.code = code;
        if (50008 == error.code || 50012 == error.code || 50014 == error.code) {
            error.message = @"";
            error.message_human = @"";
        } else {
            error.message = message;
            error.message_human = message;
        }
        
        return error;
    }
    return nil;
}

- (ZARPCErrorResponse *) bussinessError{
    if ([[ZARPCBaseRequest classBussinessDelegate] respondsToSelector:@selector(bussinessErrorForRequest:)]){
        return [[ZARPCBaseRequest classBussinessDelegate] bussinessErrorForRequest:self];
    }
    return [self ivankaError];
}

- (ZARPCErrorResponse *) wscnError{
    return [[ZARPCErrorResponse alloc] initWithContent:[self.error.userInfo objectForKey:AFNetworkingTaskDidCompleteErrorResponseKey]];
}

- (ZARPCErrorResponse *)finalError {
    if (self.sessionDataTask.state == NSURLSessionTaskStateCanceling) {
        return nil;
    }
    
    ZARPCErrorResponse *error = [self bussinessError];
    if (!error) {
        error = [self wscnError];
    }
    
    if (!error) {
        error = [[ZARPCErrorResponse alloc] init];
        error.code = self.error.code;
        if (error.code == NSURLErrorNotConnectedToInternet) {
            error.message = @"已与互联网断开连接";
            error.message_human = @"已与互联网断开连接";
        } else {
            error.message = self.error.localizedDescription;
            error.message_human = self.error.localizedDescription;
        }
        
    }
    return error;
}

@end
