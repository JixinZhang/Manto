//
//  TTHomeTabResource.h
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTHomeTabResource : NSObject

@property (nonatomic, strong) NSMutableArray *tabsData;

@property (nonatomic, copy) void(^block)(NSArray *);
@property (nonatomic, copy) void(^badgeBlock)(NSString *badge);

+ (instancetype) sharedTabResource;

- (void) updateTabs:(NSMutableArray *) datas;

- (void) updateTabBagde:(NSUInteger) badge;

@end

NS_ASSUME_NONNULL_END
