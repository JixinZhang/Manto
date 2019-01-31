//
//  GoldMemoryUsage.h
//  GoldBaseFramework
//
//  Created by hushaohua on 2017/8/15.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoldMemoryUsage : NSObject

+ (long long) totoalMemorySize;

+ (long long) availableMemorySize;
+ (long long) allocatedMemorySize;

+ (long long) freeMemorySize;
+ (long long) activeMemorySize;
+ (long long) inactiveMemorySize;
+ (long long) wireMemorySize;

@end
