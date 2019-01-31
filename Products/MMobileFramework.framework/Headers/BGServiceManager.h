//
//  BGServiceManager.h
//  MobileFramework
//
//  Created by micker on 15/5/15.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGServiceManager : NSObject
@property (nonatomic, strong) NSMutableDictionary *serviceMap;  //name , object, cls

+ (instancetype) sharedInstance;

- (id) findServiceByName:(NSString *) name;

- (BOOL) unRegisterServiceByName:(NSString *) name;

- (BOOL) registerService:(id) service forName:(NSString *) name;

- (void) registerCommonServices;

- (void) runAllServices;

@end
