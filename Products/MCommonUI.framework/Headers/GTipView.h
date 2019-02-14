//
//  GTipView.h
//  HPayablePostFramework
//
//  Created by Namegold on 2017/5/25.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ConfirmButtonBlock)();
typedef void (^CancelButtonBlock)();

@interface GTipView : UIView

@property (nonatomic, copy,readonly) ConfirmButtonBlock confirmBlock;
@property (nonatomic, copy,readonly) CancelButtonBlock cancelBlock;

@property (nonatomic, assign) BOOL disableAutoDissmiss;// 默认NO,需要手动取消弹框时置为YES

/**
 展示弹窗

 @param title 标题
 @param image 图片
 @param confirmString 确认按钮标题
 @param cancelString 取消按钮标题
 @param confirmBlock 确认按钮点击回调block
 @param cancelBlock 取消按钮点击回调block
 @return 返回创建后的view
 */
+ (GTipView *)showWithTitle: (NSString *)title
                topImage: (UIImage *)image
      confirmButtonTitle: (NSString *)confirmString
       cancelButtonTitle: (NSString *)cancelString
            confirmBlock: (ConfirmButtonBlock )confirmBlock
             cancelBlock: (CancelButtonBlock )cancelBlock;


/**
 手动Dissmiss调弹窗(前提为disableAutoDissmiss为YES)

 @param tipView 需要移除的弹窗视图
 */
- (void)dissmissWithTipView: (GTipView *)tipView;

@end
