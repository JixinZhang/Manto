//
//  TTChannelViewController.h
//  TTChannel
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <GoldBaseFramework/GoldBaseFramework.h>
#import <MCommonUI/MCommonUI.h>
#import "TTChannelViewPresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class TTChannelViewController;

@protocol TTChannelViewControllerDataSource <NSObject>

- (NSInteger)numberOfChannelsInViewController:(TTChannelViewController *)viewController;

- (id<TTChannelViewPresenterProtocol>)channelViewController:(TTChannelViewController *)viewController presenterForChannelAtIndex:(NSInteger)index;

@end

@protocol TTChannelViewControllerDelegate <NSObject>

@optional

- (void)channelsViewController:(TTChannelViewController *)viewController willPresentChannel:(NSInteger)index;

- (void)channelsViewController:(TTChannelViewController *)viewController didEndPresentingChannel:(NSInteger)index;

- (void)channelsViewControllerDidStill:(TTChannelViewController *)viewContoller;

@end

@interface TTChannelViewController : BaseViewController<GoldSectionViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id<TTChannelViewControllerDataSource> dataSource;
@property (nonatomic, weak) id<TTChannelViewControllerDelegate> delegate;

@property (nonatomic, strong) GoldSectionView *sectionView;
@property (nonatomic, readonly) UIView *channelTitlesView;
@property (nonatomic, readonly) UIScrollView *channelContentsView;

@property (nonatomic, readonly) NSInteger currentIndex;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

- (void)registerCells;

- (void)reloadChannels;

- (void)reloadChannelAtIndex:(NSInteger)index;

- (CGRect)collectionViewFrame;

- (id<TTChannelViewPresenterProtocol>)presenterForChannelAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
