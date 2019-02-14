//
//  HNewsReusableViewProtocol.h
//  MCommonUI
//
//  Created by hushaohua on 1/12/17.
//  Copyright © 2017 WSCN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HNewsItemReuseProtocol <NSObject>

@property(nonatomic, copy) NSString* url;

- (Class) reusableViewClass;

@optional

@property(nonatomic, assign) BOOL hideLine;

- (NSInteger)resourseId;
- (NSString *)recommendTrackId;

- (BOOL) openURLOutsideApp;

- (Class) reusableViewClassForTag:(id)tag;

@property(nonatomic, strong) id reuseViewUserInfo;
- (NSString *) cellReuseId;

- (void) prepareItemForReuse:(void(^)(void))result;

- (void) itemWillBeReuse;

@end

@protocol HNewsReusableViewProtocol <NSObject>

- (void) setContentData:(id<HNewsItemReuseProtocol>)content;
+ (CGSize) reuseViewSizeForContent:(id<HNewsItemReuseProtocol>)content;

@optional
- (void) reuseViewWillDisplay;
- (void) reuseViewDidEndDisplay;
- (void) reuseViewIndexPath:(NSIndexPath *)indexPath;
- (void) reuseViewDelegate:(id)delegate;

@property(nonatomic, copy) BOOL(^reuseViewHandleEventBlock)();

- (void) reuseViewDidDisplayCompleted;//全部展现
- (void) reuseViewWillDisplayInCompleted;//未全部展现

- (void) checkCompletedDisplayAtOffset:(CGPoint)offset
                           visibleSize:(CGSize)visibleSize;

- (void) reuseViewDidClick;

@optional
+ (id) reuseViewUserInfoForContent:(id<HNewsItemReuseProtocol>)content;
+ (id) reuseViewUserInfoForContent:(id<HNewsItemReuseProtocol>)content constraintViewSize:(CGSize)size;
+ (id) reuseViewUserInfoForContent:(id<HNewsItemReuseProtocol>)content constraintViewSize:(CGSize)size atIndexPath:(NSIndexPath *)indexPath;

//update
+ (void) updateReuseViewUserInfoForContent:(id<HNewsItemReuseProtocol>)content withReason:(id)reason;
+ (void) updateReuseViewUserInfoForContent:(id<HNewsItemReuseProtocol>)content constraintViewSize:(CGSize)size withReason:(id)reason;
+ (void) updateReuseViewUserInfoForContent:(id<HNewsItemReuseProtocol>)content constraintViewSize:(CGSize)size atIndexPath:(NSIndexPath *)indexPath withReason:(id)reason;

@end
