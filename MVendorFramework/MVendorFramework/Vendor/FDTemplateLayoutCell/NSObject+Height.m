//
//  NSObject+Height.m
//  MVendorFramework
//
//  Created by Micker on 16/8/1.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "NSObject+Height.h"
#import <objc/runtime.h>

@implementation NSObject (Height)

- (void) setTableViewItemHeight:(float)tableViewItemHeight {
    objc_setAssociatedObject(self, @selector(tableViewItemHeight), [NSNumber numberWithFloat:tableViewItemHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float) tableViewItemHeight {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return [number floatValue];
}
@end
