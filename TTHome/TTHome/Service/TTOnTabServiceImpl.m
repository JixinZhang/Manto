//
//  TTOnTabServiceImpl.m
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTOnTabServiceImpl.h"
#import "TTHomeTabResource.h"

@implementation TTOnTabServiceImpl

- (void) start {
    DEBUGLOG(@"");
}

- (void) updateTabItems:(NSArray *) items {
    if (!items) {
        return;
    }
    //    NSString *keys[] = {@"news",@"live",@"market",@"me"};
    NSString *suff[] = {@"label",@"normal",@"pressed",@"night_Normal",@"night_Pressed", @"activity"};
    
    //    NSMutableString *key = nil;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0 ; i < 5; i ++) {
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:5];
        NSDictionary *dic = items[i];
        
        for (int j = 0 ; j < 6 ; j++) {
            NSString *value = [dic objectForKey:suff[j]];
            if (value) {
                [temp addObject:value];
            }
        }
        [result addObject:temp];
    }
    [[TTHomeTabResource sharedTabResource] updateTabs:result];
}

- (void)refreshTabbarBadge {
    [self refreshTabbarBadgeValueAndShowBadge:YES block:NULL];
}

- (void) refreshTabbarBadgeValueWithBlock:(voidBlock)completeBlock {
    [self refreshTabbarBadgeValueAndShowBadge:NO block:completeBlock];
}

/**
 请求了bage value
 
 @param showBage 是否需要展示badge
 */
- (void)refreshTabbarBadgeValueAndShowBadge:(BOOL)showBage block:(voidBlock)block {
    
}

@end
