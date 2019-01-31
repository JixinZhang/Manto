//
//  GoldDataBaseProtocol.h
//  GoldDataFramework
//
//  Created by Micker on 16/5/16.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GoldDataBaseProtocol <NSObject, NSCoding>

@required
- (NSString *) dbTablePrimaryKey;

@optional

- (NSString *) dbTableName;

- (NSString *) dbConditionKeys;

@end
