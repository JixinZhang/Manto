//
//  TTChannelCollectionViewCell.m
//  TTChannel
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTChannelCollectionViewCell.h"

@interface TTChannelCollectionViewCell()

@property (nonatomic, weak) NSArray *accessoryViews;
@property (nonatomic, strong) UIView *loadingView;

@end

@implementation TTChannelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setChannelViewPresenter:(id<TTChannelViewPresenterProtocol>)channelViewPresenter {
    if (_channelViewPresenter != channelViewPresenter) {
        [_channelViewPresenter viewDidEndPresenting];
        _channelViewPresenter = channelViewPresenter;
        
        [channelViewPresenter setContentView:[self mainView]];
        [self channelViewDidLoad];
        if ([channelViewPresenter respondsToSelector:@selector(accessoryViews)]) {
            self.accessoryViews = channelViewPresenter.accessoryViews;
        }
        
    } else {
        [channelViewPresenter setContentView:[self mainView]];
    }
}

- (void)setAccessoryViews:(NSArray *)accessoryViews {
    if (_accessoryViews != accessoryViews) {
        [_accessoryViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _accessoryViews = accessoryViews;
        for (UIView *view in accessoryViews) {
            [self.contentView addSubview:view];
        }
    }
}

- (void)channelViewDidLoad {
    
}

- (UIView *) loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:self.bounds];
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/2-40, 200, 80, 80)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont fontWithName:@"iconfont" size:48.0f];
        tipLabel.textColor = [UIColor getColor:@"f0f3f5"];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"\U0000e604";
        tipLabel.tag = 1001;
        [_loadingView addSubview:tipLabel];
    }
    return _loadingView;
}

- (id) mainView{
    return nil;
}

- (void)centerLoadingView {
    UILabel *tipLabel = [self.loadingView viewWithTag:1001];
    tipLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) / 2 - 40, 200, 80, 80);
}

@end
