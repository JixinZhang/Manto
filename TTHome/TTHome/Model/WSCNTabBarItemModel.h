//
//  WSCNTabBarItemModel.h
//  MHomeFramework
//
//  Created by AlexZhang on 2018/12/5.
//  Copyright © 2018 Micker. All rights reserved.
//

#import <GoldRPCFramework/GoldRPCFramework.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSCNTabBarItemActivityModel : GoldBaseReponse

@property (nonatomic, copy) NSString *normal;
@property (nonatomic, copy) NSString *pressed;
@property (nonatomic, copy) NSString *night_Normal;
@property (nonatomic, copy) NSString *night_Pressed;

- (BOOL)showActivity;

@end

@interface WSCNTabBarItemModel : GoldBaseReponse

@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *normal;
@property (nonatomic, copy) NSString *pressed;
@property (nonatomic, copy) NSString *night_Normal;
@property (nonatomic, copy) NSString *night_Pressed;
@property (nonatomic, strong) WSCNTabBarItemActivityModel *activity;

- (void)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
