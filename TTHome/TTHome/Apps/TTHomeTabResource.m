//
//  TTHomeTabResource.m
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTHomeTabResource.h"

@implementation TTHomeTabResource

+ (instancetype) sharedTabResource {
    static TTHomeTabResource *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[TTHomeTabResource alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *array = @[
                           @[@"首页",@"home_tabbar_32x32_",@"home_tabbar_press_32x32_",@"home_tabbar_night_32x32_",@"home_tabbar_night_press_32x32_"],
                           @[@"西瓜视频",@"video_tabbar_32x32_",@"video_tabbar_press_32x32_",@"video_tabbar_night_32x32_",@"video_tabbar_night_press_32x32_"],
                           @[@"小视频",@"weitoutiao_tabbar_32x32_",@"weitoutiao_tabbar_press_32x32_",@"weitoutiao_tabbar_night_32x32_",@"weitoutiao_tabbar_night_press_32x32_"],
                           @[@"未登录",@"no_login_tabbar_32x32_",@"no_login_tabbar_press_32x32_",@"no_login_tabbar_night_32x32_",@"no_login_tabbar_night_press_32x32_"
                             ]];
        self.tabsData = [NSMutableArray arrayWithArray:array];
    }
    return self;
}


- (void) updateTabs:(NSMutableArray *) datas {
    if (datas) {
        self.tabsData = datas;
    }
    !self.block?:self.block(self.tabsData);
}

- (void) updateTabBagde:(NSUInteger) badge {
    NSString *badgeValue = nil;
    if (badge == 0) {
        !self.badgeBlock?:self.badgeBlock(nil);
    } else {
        badgeValue = [NSString stringWithFormat:@"%lu",badge];
        !self.badgeBlock?:self.badgeBlock(badgeValue);
    }
    return;
}

@end
