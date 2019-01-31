//
//  BGTaskDispatcher.h
//  MMobileFramework
//
//  Created by Micker on 2017/12/21.
//  Copyright © 2017年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TaskExecuteMode) {
    TaskExecuteModeDefault,
    TaskExecuteModeCommon
};

@interface BGTaskDispatcher : NSObject

+ (id) taskDefault;

+ (id) taskCommon;

- (id) initWithMode:(TaskExecuteMode) mode;

- (void) addTaskIdentifier:(NSString *) taskIdentifier task:(void(^)())task;

- (void) cancelTaskIdentifier:(NSString *) taskIdentifier;

- (void) reset;
@end
