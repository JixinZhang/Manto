//
//  mBullContextInterface.h
//  MobileFramework
//
//  Created by micker on 15/5/14.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

@protocol mBullContext <NSObject>

- (NSString *) appKey;

- (id) serviceWithName:(NSString *) name;

- (void) registerMethod:(NSString *) method service:(NSString *) service;

- (void) unregisterMethod:(NSString *) method;

- (id) executeMethod:(NSString *) method arguments:(NSDictionary *) arguments;


@end