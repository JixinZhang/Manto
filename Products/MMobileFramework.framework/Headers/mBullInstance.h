//
//  mBullInstance.h
//  MobileFramework
//
//  Created by micker on 15/5/18.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mBullContext.h"
#import "mBullAppInterface.h"

@interface mBullInstance : NSObject <mBullContext>
@property (nonatomic, copy, getter=appKey) NSString *identifiy;
@property (nonatomic, strong) id<mBullAppInterface> mBullInstance;

+ (instancetype) sharedInstance;

@end
