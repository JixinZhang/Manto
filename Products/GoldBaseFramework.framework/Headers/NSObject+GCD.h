//
//  NSObject+GCD.h
//  GoldBaseFramework
//
//  Created by Caoguo on 2018/5/21.
//  Copyright © 2018年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCD)


/**
 延时执行某个blcok

 @param handle handleBlock
 @param delay delay
 */
- (void)performHandleBlock:(void(^)(void))handle afterDelay:(NSTimeInterval)delay;

@end
