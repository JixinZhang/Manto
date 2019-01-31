//
//  GoldDataOperateCenter.h
//  GoldDataFramework
//
//  Created by Micker on 16/5/16.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoldDataBaseProtocol.h"
#import "FMDB.h"

@interface GoldDataOperateCenter : NSObject
@property (nonatomic, strong, readonly) FMDatabaseQueue *queue;
@property (nonatomic, copy) NSString *databasePath;

+ (instancetype) sharedInstance;

- (BOOL) checkTableExist:(id<GoldDataBaseProtocol>) data create:(BOOL) create block:(void(^)(NSError *error)) block;

- (void) selectDB:(id<GoldDataBaseProtocol>) data block:(void(^)(NSArray *items, NSError *error)) block;

- (void) selectAllDB:(id<GoldDataBaseProtocol>) data block:(void(^)(NSArray *items, NSError *error)) block;

- (void) selectDB:(id<GoldDataBaseProtocol>) data block:(void(^)(NSArray *items, NSError *error)) block limit:(NSUInteger) limit offSet:(NSUInteger)offset;

- (void) insertDB:(id<GoldDataBaseProtocol>) data block:(void(^)(NSError *error)) block;

- (void) updateDB:(id<GoldDataBaseProtocol>) data block:(void(^)(NSError *error)) block;

- (void) deleteDB:(id<GoldDataBaseProtocol>) data block:(void(^)(NSError *error)) block;

- (void) dropDB:(id<GoldDataBaseProtocol>) data block:(void(^)(NSError *error)) block;

@end
