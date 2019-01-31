//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)

@property (nonatomic, assign) BOOL disenablePenetration;   //关闭点击事件穿透MBProgress。默认为NO，即不关闭事件穿透

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showInfo:(NSString *)error toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showOnlyText:(NSString *)text toView:(UIView *)view;

+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *) showProgressText:(NSString *)text toView:(UIView *)view;

+ (MBProgressHUD *) showProgressText:(NSString *)text toView:(UIView *) view mode:(MBProgressHUDMode)mode;
@end
