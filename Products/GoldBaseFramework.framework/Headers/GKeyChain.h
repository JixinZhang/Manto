//
//  GKeyChain.h
//  MPushFramework
//
//  Created by wscn on 2017/3/23.
//  Copyright © 2017年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKeyChain : NSObject


/**
 保存keychain

 @param keyChainName 名字(key)
 @param password 密码
 */
+ (void)saveKeyChain: (NSString *)keyChainName password: (id )password;


/**
 获取keychain

 @param keyChainName 名字(key)
 @return 密码
 */
+ (id)loadKeyChain: (NSString *)keyChainName;


/**
 删除keychain

 @param keyChainName 名字(key)
 */
+ (void)deleteKeyChain: (NSString *)keyChainName;

@end
