//
//  NSDictionary+Response.m
//  GoldRPCFramework
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "NSDictionary+Response.h"

@implementation NSDictionary (Response)

- (NSString *) stringValueForKey:(NSString *) key {
    NSString * stringValue = [self objectForKey:key];
    return (stringValue != (NSString *)[NSNull null]) ? stringValue : @"";
}

- (NSInteger) integerValueForKey:(NSString *) key {
    NSNumber *num = [self objectForKey:key];
    return (num != (NSNumber *)[NSNull null]) ? [num integerValue] : 0;
}

- (float) floatValueForKey:(NSString *) key {
    NSNumber *num = [self objectForKey:key];
    return (num != (NSNumber *)[NSNull null]) ? [num floatValue] : 0.0f;
}

- (BOOL) boolValueForKey:(NSString *) key {
    NSNumber *num = [self objectForKey:key];
    return (num != (NSNumber *)[NSNull null]) ? [num boolValue] : NO;
}

- (NSDate *) dateValueForKey:(NSString *) key {
    NSNumber *num = [self objectForKey:key];
    NSDate * value = nil;
    if (num != (NSNumber *)[NSNull null]) {
        value = [NSDate dateWithTimeIntervalSince1970:[num doubleValue]];
    }
    return value;
}

- (NSArray *) arrayValueForKey:(NSString *) key {
    NSArray * arrayValue = [self objectForKey:key];
    if ([arrayValue isKindOfClass:[NSArray class]]){
        return arrayValue;
    }
    return nil;
}

- (NSDictionary *) dictionaryValueForKey:(NSString *) key {
    NSDictionary * dictionaryValue = [self objectForKey:key];
    if ([dictionaryValue isKindOfClass:[NSDictionary class]]){
        return dictionaryValue;
    }
    return nil;
}

@end
