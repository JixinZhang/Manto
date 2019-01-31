//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"
#import <objc/message.h>

static float HUD_MARGIN = 12.0f;

@implementation MBProgressHUD (Add)

#pragma mark 显示信息
+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (text.length == 0) {
        return nil;
    }
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.square = NO;
    
//    hud.labelColor = [UIColor whiteColor];
    hud.labelFont = [UIFont systemFontOfSize:15.0f];
    
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    
    hud.margin = HUD_MARGIN;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0];
    

    return hud;
}

+ (MBProgressHUD *) showProgressText:(NSString *)text toView:(UIView *) view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = [UIColor whiteColor];
    if (text.length > 0) {
        hud.label.text = text;
        hud.label.textColor = [UIColor whiteColor];
    }
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    return hud;
}

+ (MBProgressHUD *) showProgressText:(NSString *)text toView:(UIView *) view mode:(MBProgressHUDMode)mode{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = [UIColor whiteColor];
    if (text.length > 0) {
        hud.label.text = text;
        hud.label.textColor = [UIColor whiteColor];
    }
    hud.mode = mode;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    return hud;
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error" view:view];
}

+ (void)showInfo:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"info" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success" view:view];
}

+ (void)showOnlyText:(NSString *)text toView:(UIView *)view
{
    if (text.length == 0) {
        return;
    }
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    [hud hideAnimated:YES afterDelay:1.0];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    if (message.length > 0) {
        hud.label.text = message;
        hud.label.textColor = [UIColor whiteColor];
    }
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

- (void)setDisenablePenetration:(BOOL)disenablePenetration {
    objc_setAssociatedObject(self, @selector(disenablePenetration), @(disenablePenetration), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)disenablePenetration {
    return objc_getAssociatedObject(self, @selector(disenablePenetration));
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.disenablePenetration) {
        return [super hitTest:point withEvent:event];
    }
    return nil;
}
@end
