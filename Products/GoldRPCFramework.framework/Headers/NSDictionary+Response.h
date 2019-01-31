//
//  NSDictionary+Response.h
//  GoldRPCFramework
//
//  Created by Micker on 16/5/12.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Response)

- (NSString *) stringValueForKey:(NSString *) key;

- (NSInteger) integerValueForKey:(NSString *) key;

- (float) floatValueForKey:(NSString *) key;

- (BOOL) boolValueForKey:(NSString *) key;

- (NSDate *) dateValueForKey:(NSString *) key;

- (NSArray *) arrayValueForKey:(NSString *) key;

- (NSDictionary *) dictionaryValueForKey:(NSString *) key;

@end
