//
//  ZChannelsSort.h
//  GoldBaseFramework
//
//  Created by WSCN on 16/05/2017.
//  Copyright © 2017 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZChannelsSort : NSObject

/**
 设定cell只能在其所在的section中移动。默认为NO，即可以跨越section移动
 */
@property (nonatomic, assign) BOOL onlyMoveInSection;

/**
 点击排序视图的最上方透明处隐藏排序视图，然后触发cancelBlock
 */
@property (nonatomic, copy) void (^cancelBlock)();

/**
 排序结束点击“完成”，将排好序的频道结果返回。
 sortedChannels字典中包含三对key-value：
 picked     对应已选频道，是一个数组；
 unpicked   对应未选频道，为一个数组；
 isChanged  判断顺序是否真的最终改变，为BOOL。
 */
@property (nonatomic, copy) void (^channelsSortBlock)(NSDictionary *sortedChannels);

/**
 将频道排序视图添加到当前ViewController的window上

 @param viewController 排序视图添加到所在的ViewController的window上
 @param channels 需要排序的频道 channels字典中包含两对key-value：picked 对应已选频道，是一个数组；unpicked   对应未选频道，为一个数组。
 */
- (void)sortChannelsAtViewController:(UIViewController *)viewController WithDictionary:(NSDictionary *)channels;

/**
 将频道排序视图添加到当前view的window上

 @param view 排序视图添加到所在的view的window上
 @param channels 需要排序的频道 channels字典中包含两对key-value：picked 对应已选频道，是一个数组；unpicked   对应未选频道，为一个数组。
 */
- (void)sortChannelsAtView:(UIView *)view WithDictionary:(NSDictionary *)channels;

/**
 对外暴露的关闭排序视图的方法
 */
- (void)hideSortView;

@end
