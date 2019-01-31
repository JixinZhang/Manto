//
//  FullViewController.m
//  MVendorFramework
//
//  Created by Micker on 16/9/14.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "FullViewController.h"



@implementation FullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.baidu.com"]]];
    [self.view addSubview:webView];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
#pragma mark --StatusBar

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

@end
