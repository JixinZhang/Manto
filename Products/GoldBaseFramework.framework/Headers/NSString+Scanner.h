//
//  NSString+Scanner.h
//  GoldBaseFramework
//
//  Created by 王昱斌 on 2018/6/4.
//  Copyright © 2018年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Scanner)

/**
 验证字符串是否是整型

 @param string 要验证的字符串
 @return 是否是整型
 */
+ (BOOL)isPureInt:(NSString*)string;

/**
 验证字符串是否是浮点型

 @param string 要验证的字符串
 @return 是否是浮点型
 */
+ (BOOL)isPureFloat:(NSString*)string;

@end
