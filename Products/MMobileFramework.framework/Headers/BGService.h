//
//  BGService.h
//  MobileFramework
//
//  Created by micker on 15/5/18.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BGService <NSObject>
@required

- (void)start;

@optional

- (void)didCreate;

- (void)willDestroy;

@end
