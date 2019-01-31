//
//  WSCNTabBarItem.h
//  MHomeFramework
//
//  Created by AlexZhang on 2018/12/5.
//  Copyright © 2018 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWSCNTabBarItemWidth 60
#define kWSCNTabBarItemHeight 57
#define kWSCNTabBarItemRatio (57/60.0)

@interface WSCNTabBarItem : UIButton

/**
 活动的图片，未选中状态
 */
@property (nonatomic, strong) UIImage *normalImage;

/**
 活动的图片，选中状态
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 当需要显示活动图片时，通过backgroundView 挡住UIButton原本的imageView和titleLabel
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 WSCNTabBarItem 是否选中
 */
@property (nonatomic, assign) BOOL wscnSelected;

/**
 WSCNTabBarItem 是否展示活动图片
 */
@property (nonatomic, assign) BOOL showActivity;

- (void) downloadImage:(NSString *)image width:(NSInteger)width height:(NSInteger)height block:(void(^)(UIImage *image)) block;

@end
