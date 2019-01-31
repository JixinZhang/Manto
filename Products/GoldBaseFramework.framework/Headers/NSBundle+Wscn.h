//
//  NSBundle+Wscn.h
//  GoldBaseFramework
//
//  Created by Micker on 16/8/29.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MLocalizedString(key, bundleName) \
[NSBundle wscnLocalizedStringForKey:(key) value:@"" bundle:bundleName table:nil comment:nil]

@interface NSBundle (Wscn)

- (NSString *) appShortVersion;

- (NSString *) appBoundIdentifier;

- (NSString *) appName;

- (NSString *) appContentForKey:(NSString *) key;

- (BOOL)isZh;


/**
 国际化，或bundleName不为空，则在该bundl下进行查找，若不存在，则到mainBundle上再次查找
 
 @param key key
 @param value ""
 @param bundleName 取bundle文件的名称，不包含后缀
 @param table table名称，一般用于自定义
 @param comment 无用参数
 @return 具体国际化名称
 */
+ (NSString *) wscnLocalizedStringForKey:(NSString *) key
                                   value:(NSString *) value
                                  bundle:(NSString *) bundleName
                                   table:(NSString *) table
                                 comment:(NSString *) comment;

@end
