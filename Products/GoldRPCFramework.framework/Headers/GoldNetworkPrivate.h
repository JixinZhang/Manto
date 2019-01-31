//
//  GoldNetworkPrivate.h
//  B5MRPCFramework
//
//  Created bymickeron 15/11/11.
//  Copyright © 2015年 Micker All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoldBaseRequest.h"

@interface GoldNetworkPrivate : NSObject

// 检查服务器所给的字段类型和自定义公司的字段类型是否一致
+ (BOOL)checkJSON:(id)json withValidator:(id)validatorJson;

// 对URL添加一些全局的参数(像APP Version)
+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString
                          appendParameters:(NSDictionary *)parameters;


+ (void)addDoNotBackupAttribute:(NSString *)path;

+ (NSString *)md5StringFromString:(NSString *)string;

+ (NSString *)appVersionString;

@end


@interface GoldBaseRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end