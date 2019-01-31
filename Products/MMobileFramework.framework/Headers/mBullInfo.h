//
//  mBullInfo.h
//  MobileFramework
//
//  Created by micker on 15/5/18.
//  Copyright (c) 2015年 Micker.cn  All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BGService;

@interface mBullInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *classString;
@property (nonatomic, copy) NSString *descript;
@property (nonatomic, strong) NSDictionary *options;
@property (nonatomic, assign) BOOL lazyload;
@property (nonatomic, assign) BOOL  didRun;

- (id) initWithDictionary:(NSDictionary *) dictionary;

- (id<BGService>) idWithClass;

- (id) runService;

- (id) forceRunService;
@end
