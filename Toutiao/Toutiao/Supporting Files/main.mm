//
//  main.m
//  TouTiao
//
//  Created by AlexZhang on 2019/1/25.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMobileFramework/MMobileFramework.h>
#import <GoldLogFramework/GoldLogFramework.h>
#import "GoldLog+Mars.h"
#import "TouTiaoOnStartServiceImpl.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [GoldLog startMarsLog];
//        mBullInit(@"wscn", [TouTiaoOnStartServiceImpl class]);
        [[BGContext sharedInstance].window makeKeyAndVisible];
        return UIApplicationMain(argc, argv, @"UIApplication", @"BGClientDelegate");
    }
}
