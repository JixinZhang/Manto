//
//  YYLabel+ZYExtenion.m
//  MVendorFramework
//
//  Created by 朱义 on 2018/9/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "YYLabel+ZYExtenion.h"

@implementation YYLabel (ZYExtenion)

-(void)setHighlightBgColor:(UIColor *)highlightBgColor {
    objc_setAssociatedObject(self, @selector(highlightBgColor), highlightBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(UIColor *)highlightBgColor {
    UIColor *_highlightBgColor = objc_getAssociatedObject(self, _cmd);
    return _highlightBgColor;
}

-(void)setOriginBgColor:(UIColor *)originBgColor {
    objc_setAssociatedObject(self, @selector(originBgColor), originBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(UIColor *)originBgColor {
    return objc_getAssociatedObject(self, _cmd);
}


- (void) showHighlightBg{
    if (self.highlightBgColor) {
        self.backgroundColor = self.highlightBgColor;
    }
}

- (void) hiddenHighlightBg {
    if (self.highlightBgColor) {
        __weak __typeof__(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.backgroundColor = [UIColor clearColor];
        });
    }
    
}

@end
