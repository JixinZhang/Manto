//
//  UIViewController+Appear.m
//  WSCN
//
//  Created by AlexZhang on 2018/8/27.
//  Copyright © 2018 jgCho. All rights reserved.
//

#import "UIViewController+Appear.h"
#import <objc/runtime.h>

@implementation UIViewController (Appear)

+ (void)load {
    Class class = [self class];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(class, @selector(viewWillAppear:));
        Method swizzeldMethod = class_getInstanceMethod(class, @selector(swizzleViewWillAppear:));
        method_exchangeImplementations(originalMethod, swizzeldMethod);
    });
}

- (void)swizzleViewWillAppear:(BOOL)animated {
    [self swizzleViewWillAppear:animated];
    
    NSString *classString = NSStringFromClass([self class]);
    DEBUGLOG(@"ViewController class = %@", classString);
    if ([classString hasPrefix:@"UI"] ||
        [classString hasPrefix:@"IJKSDLHudViewController"] ||
        [classString hasPrefix:@"YPlayerFullScreenWindowRootViewController"] ||
        [classString hasPrefix:@"HPopupADsViewController"] ||
        [classString hasPrefix:@"HSplashADViewController"]) {
        return;
    }
}

@end
