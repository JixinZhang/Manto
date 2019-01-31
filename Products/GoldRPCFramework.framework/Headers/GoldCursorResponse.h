//
//  GoldCursorResponse.h
//  GoldRPCFramework
//
//  Created by hushaohua on 2/8/17.
//  Copyright © 2017 wallstreetcn. All rights reserved.
//

#import "GoldBaseReponse.h"

@class GoldCursorResponse;
@protocol GoldCursorResponseDelegate <NSObject>

@optional
//call when addPageContent:cursor:
//在加入列表前对items进行处理或更新\替换items
- (NSArray *) response:(GoldCursorResponse *)response willAddItems:(NSArray *)items;

@end

@interface GoldCursorResponse : GoldBaseReponse

@property(nonatomic, weak) id<GoldCursorResponseDelegate> delegate;
@property(nonatomic, readonly) NSArray* items;
@property(nonatomic, readonly) NSString* nextCursor;
@property(nonatomic) NSUInteger totalCount;

@property(nonatomic) Class responseItemClass;

//初始化使用 init, 而不是使用initWithContent:
//当cursor不为nil时，cursor必须于self.nextCursor相等
- (NSArray *) addPageContent:(id)content cursor:(NSString *)cursor;
- (void) itemsDidAdded; //items解析完成后

- (NSString *) responseNextCursorKey;
- (NSString *) responseItemsKey;
- (NSString *) responseTotalCountKey;

- (void) appendItems:(NSArray *)items;
- (void) insertItems:(NSArray *)items atIndex:(NSInteger)index;

- (void) removeItem:(id)item;

- (void) moveItem:(id)item toIndex:(NSInteger)index;
- (void) moveItemAtIndex:(NSInteger)index toIndex:(NSInteger)index;

- (void) replaceItem:(id)targetItem with:(id)replacedItem;

@end
