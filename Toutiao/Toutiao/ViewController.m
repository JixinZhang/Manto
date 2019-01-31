//
//  ViewController.m
//  TouTiao
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat x = (arc4random() * 100 % 255);
    self.view.backgroundColor = [UIColor getColor:x + 20 : x - 70 : x + 50];
}

- (BOOL)fd_prefersNavigationBarHidden {
    return NO;
}

@end
