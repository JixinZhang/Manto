//
//  ViewController.m
//  testFDFullScreen
//
//  Created by Micker on 16/9/14.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "ViewController.h"
#import "FullViewController.h"
#import "PullRefreshViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@" 确定" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(20, 100, 200, 40)];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@" PULL" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(20, 150, 200, 40)];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(pullAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (IBAction)doneAction:(id)sender {
    FullViewController *controller = [[FullViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)pullAction:(id)sender {
    PullRefreshViewController *controller = [[PullRefreshViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark --StatusBar

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}


@end
