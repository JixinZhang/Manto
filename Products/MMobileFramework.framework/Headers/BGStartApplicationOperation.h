//
//  BGStartApplicationOperation.h
//  MobileFramework
//
//  Created by micker on 15/5/19.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>

@class BGStartApplicationOperation;
@class BGMicroApplication;
typedef void (^voidBlock)();


@interface BGStartApplicationOperation : NSOperation
@property (nonatomic, copy) voidBlock block;
@property (nonatomic, weak) BGMicroApplication *application;

@end
