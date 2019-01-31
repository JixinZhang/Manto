//
//  GoldBaseRequest+Error.h
//  GoldRPCFramework
//
//  Created by hushaohua on 10/26/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import "GoldBaseRequest.h"

@class GoldErrorResponse;
@interface GoldBaseRequest (Error)

- (GoldErrorResponse *) wscnError;
- (GoldErrorResponse *) ivankaError;
- (GoldErrorResponse *) bussinessError;//same as ivankaError

- (GoldErrorResponse *) finalError;

@end
