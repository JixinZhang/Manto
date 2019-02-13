//
//  NSDictionary+Response.h
//  GoldRPCFramework
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
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
