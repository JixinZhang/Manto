//
//  TTNewsListRequest.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTNewsListRequest.h"

@implementation TTNewsListRequest

- (NSString *)requestUrl {
    return @"api/news/feed/v58/";
}

- (id)requestArgument {
    NSMutableDictionary *argument = [NSMutableDictionary dictionaryWithCapacity:4];
    if (self.category.length) {
        [argument setValue:self.category forKey:@"category"];
    }
    [argument setValue:TT_IID forKey:@"iid"];
    [argument setValue:TT_DEVICE_ID forKey:@"device_id"];
    [argument setValue:@"iphone" forKey:@"device_platform"];
    return argument;
}

@end
