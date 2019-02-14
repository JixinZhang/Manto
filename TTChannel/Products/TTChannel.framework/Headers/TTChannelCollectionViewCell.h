//
//  TTChannelCollectionViewCell.h
//  TTChannel
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTChannelViewPresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTChannelCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly) UIView *loadingView;
@property (nonatomic, weak) id<TTChannelViewPresenterProtocol> channelViewPresenter;

- (void)channelViewDidLoad;

- (id)mainView;

- (void)centerLoadingView;

@end

NS_ASSUME_NONNULL_END
