//
//  BGBootLoader.h
//  MobileFramework
//
//  Created by micker on 15/5/15.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGBootLoader : NSObject

- (id) initWithConfig:(NSString *) config;

- (void) start;

@end
