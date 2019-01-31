//
//  LNTheme+WSCN.m
//  WSCN
//
//  Created by ZhangBob on 02/03/2017.
//  Copyright © 2017 jgCho. All rights reserved.
//

#import "LNTheme+WSCN.h"

@implementation LNTheme (WSCN)

- (void)registerTheme_WSCN {
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"wscnDay" ofType:@"json"];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"wscnNight" ofType:@"json"];
    [[self class] addTheme:LN_THEME_DEFAULT_NAME forPath:path1];
    [[self class] addTheme:@"night" forPath:path2];
}

@end
