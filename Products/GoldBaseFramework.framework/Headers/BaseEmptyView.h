//
//  BaseEmptyView.h
//  GoldBaseFramework
//
//  Created by Micker on 2016/10/24.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 默认显示空视图，图片在上，标签在下
 */
@interface BaseEmptyView : UIControl

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel   *label;

@end


#pragma mark UIView ( emptyView )

/**
 空页面的类型

 - BaseEmptyViewTypeDefault: 默认是“空空如也”，图片为一个小人站在一个空箱子旁边
 */
typedef NS_ENUM(NSInteger, BaseEmptyViewType) {
    BaseEmptyViewTypeDefault = 0,           //默认，空空如也
    BaseEmptyViewType404,                   //404
    BaseEmptyViewTypeNote,                  //暂无笔记
    BaseEmptyViewTypeOrder,                 //暂无订单
    BaseEmptyViewTypeCoupon,                //暂无票券
    BaseEmptyViewTypeComment,               //暂无评论
    BaseEmptyViewTypeNetwork,               //暂无网络
    BaseEmptyViewTypeMessage,               //暂无消息
    BaseEmptyViewTypeTurnover,              //暂无明细
    BaseEmptyViewTypePremiumTopic,          //暂无特辑--离线
    BaseEmptyViewTypeMedia,                 //暂无音视频--离线
    BaseEmptyViewTypeArticle,               //暂无文章--离线
    BaseEmptyViewTypeFollow,                //暂无关注
    BaseEmptyViewTypeCollection,            //暂无收藏
    BaseEmptyViewTypeDataLoadingFailded     //数据加载失败
};

@interface UIView ( emptyView )

@property (nonatomic, strong) BaseEmptyView   *baseEmptyView;


/**
 显示带有提示标签的空视图，注意，若未主动设置baseEmptyView，则使用默认空视图【220 * 200】，且在当前视图的正中间

 @param tips 提示语句
 */
- (void) showEmptyViewWith:(NSString *) tips;

- (void) showEmptyViewWith:(NSString *) tips hideEmpty:(BOOL)isHidden;

- (void) showEmptyViewWith:(NSString *)tips type:(BaseEmptyViewType)type;

- (void) showEmptyViewWith:(NSString *)tips type:(BaseEmptyViewType)type hideEmpty:(BOOL)isHidden;

/**
 隐藏当前空视图
 */
- (void) hideEmptyView;

- (void) updateEmptyViewFrameY:(CGFloat)viewY;

@end
