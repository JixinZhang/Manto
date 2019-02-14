//
//  TTChannelViewPresenterProtocol.h
//  TTChannel
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewPresenterProtocol;
@protocol TTChannelViewPresenterProtocol <ViewPresenterProtocol>

- (Class) collectionViewCellClass;

@optional

- (void)closeVideoPlayer;
- (BOOL)shouldShowLoading;
- (UIStatusBarStyle)preferredStatusBarStyle;

//----------reload
- (void) reloadChannelContent:(BOOL)animated;
- (void) reloadDataIfNoData;
- (void) requestPresenterData;

//--------title user info
@property(nonatomic, strong) NSDictionary* channelUserInfo;
@property(nonatomic, copy) NSString* channelUrl;
@property(nonatomic, copy) NSString* channelTitle;
@property(nonatomic, assign) BOOL rotateScreenAlready;

//----------------------------
- (NSString *) collectionReuseId;
- (NSString *) collectionReuseIdAtIndex:(NSInteger)index;
- (UIEdgeInsets) mainViewEdge;

- (NSArray *) accessoryViews;

- (void)requestThemeUpdateCount;

@end

