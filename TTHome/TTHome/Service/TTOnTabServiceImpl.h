//
//  TTOnTabServiceImpl.h
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTOnTabService <BGService>

- (void) updateTabItems:(NSArray *) items;

- (void) refreshTabbarBadge;

- (void) refreshTabbarBadgeValueWithBlock:(voidBlock)completeBlock;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TTOnTabServiceImpl : NSObject <TTOnTabService>

@end

NS_ASSUME_NONNULL_END
