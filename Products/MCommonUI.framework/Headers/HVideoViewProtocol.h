//
//  HVideoViewProtocol.h
//  JLiveRoomFramework
//
//  Created by hushaohua on 2017/3/8.
//  Copyright © 2017年 jgCho. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HVideoViewProtocol <NSObject>

@end

@protocol HVideoViewPresenterDelegate <NSObject>

- (void) videoPlayStatusDidChanged;

@optional
- (void) videoWillToPlay;
- (void) videoWillToPause;
- (void) videoDidFinished;

@end

@protocol HVideoViewPresenterProtocol <NSObject>

@property(nonatomic, copy) void(^backActionForController)();
@property(nonatomic, copy) void(^barsAnimationDoing)(BOOL isBarOutside);
- (void) linkToVideoView:(id<HVideoViewProtocol>)videoView;

- (void) playVideoUrl:(NSString *)videoUrl;
- (void) stopVideo;
- (void) pauseVideo;

@optional
@property(nonatomic, weak) id<HVideoViewPresenterDelegate> presenterDelegate;
@property(nonatomic, copy) void(^finishOrientedPortriat)();
@property(nonatomic, weak) UIViewController* viewController;

- (BOOL) isPlaying;
- (void) autoOrientedPortriat;
- (void) linkToVideoView:(id<HVideoViewProtocol>)videoView fatherView:(UIView *)fatherView;


@end
