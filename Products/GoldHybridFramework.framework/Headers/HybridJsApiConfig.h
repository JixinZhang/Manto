//
//  HybridJsApiConfig.h
//  B5MHybridFramework
//
//  Created by Micker on 15/11/16.
//  Copyright © 2015年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HybridJsApiConfig : NSObject

@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *jsApi;
@property (nonatomic, readonly, assign) BOOL     isPrivateApi;

+ (instancetype) jsApiName:(NSString *) name jsApi:(NSString *) jsApi isPrivateApi:(BOOL) isPrivateApi;

@end
