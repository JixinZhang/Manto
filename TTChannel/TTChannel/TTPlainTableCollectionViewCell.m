//
//  TTPlainTableCollectionViewCell.m
//  TTChannel
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTPlainTableCollectionViewCell.h"

@interface TTPlainTableCollectionViewCell ()

@property(nonatomic, strong) UITableView* tableView;

@end

@implementation TTPlainTableCollectionViewCell

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.tableView];
    }
    return self;
}

- (UITableView *) tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.backgroundColor = [UIColor clearColor];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(cellLayoutMarginsFollowReadableWidth)]){
            _tableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        
        [self addThemeChangedAction];
    }
    return _tableView;
}

- (void) setChannelViewPresenter:(id<TTChannelViewPresenterProtocol>)channelViewPresenter{
    if ([channelViewPresenter respondsToSelector:@selector(shouldShowLoading)]){
        if ([channelViewPresenter shouldShowLoading]) {
//            _tableView.tableFooterView = self.loadingView;
        }
    }
    [super setChannelViewPresenter:channelViewPresenter];
    
}

- (void) addThemeChangedAction{
    __weak typeof(self) weakSelf = self;
    [_tableView ln_customThemeAction:^id{
        weakSelf.tableView.separatorColor = [LNTheme colorForType:@"g7"];
        return nil;
    }];
}

- (void) channelViewDidLoad{
    if ([self.channelViewPresenter respondsToSelector:@selector(mainViewEdge)]){
        self.tableView.frame = UIEdgeInsetsInsetRect(self.bounds, self.channelViewPresenter.mainViewEdge);
    }
    else {
        self.tableView.frame = self.bounds;
    }
    [self centerLoadingView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self channelViewDidLoad];
}

- (id) mainView{
    return self.tableView;
}

@end
