//
//  ViewController.m
//  ZARPCTest
//
//  Created by AlexZhang on 2019/2/1.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ViewController.h"
#import <ZANetwork/ZANetwork.h>
#import <ZARPC/ZARPC.h>

@interface TTNewsListRequest : ZARPCBaseRequest


@end

@implementation TTNewsListRequest

- (NSString *)requestUrl {
    return @"https://is.snssdk.com/api/news/feed/v58/?iid=17769976909";
}

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TTNewsListRequest *requst = [[TTNewsListRequest alloc] init];
    [requst startWithCompletionBlockWithSuccess:^(ZARPCBaseRequest *request) {
        NSDictionary *response = requst.responseObject;
        DEBUGLOG(@"%@", response);
    } failure:^(ZARPCBaseRequest *request) {
        
    }];
}


@end
