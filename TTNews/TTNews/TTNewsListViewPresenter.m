//
//  TTNewsListViewPresenter.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTNewsListViewPresenter.h"
#import "TTNewsListRequest.h"
#import "TTNewsListResponse.h"
#import "TTLayoutGroupPicCell.h"
#import "TTLayoutRightPicCell.h"

@interface TTNewsListViewPresenter()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TTNewsListRequest *listRequest;
@property (nonatomic, strong) TTNewsListResponse *listResponse;
@property (nonatomic, assign) BOOL animatedForFirstLoad;

@end

@implementation TTNewsListViewPresenter
@synthesize channelUserInfo = _channelUserInfo;

static NSString *groupPicCellIdentifier = @"TTLayoutGroupPicCell";
static NSString *rightPicCellIdentifier = @"TTLayoutRightPicCell";

#pragma mark - TTChannelViewPresenterProtocol

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.animatedForFirstLoad = YES;
    }
    return self;
}

- (Class)collectionViewCellClass {
    return [TTPlainTableCollectionViewCell class];
}

- (NSString *)collectionReuseIdAtIndex:(NSInteger)index {
    NSString *reuseId = [NSString stringWithFormat:@"TTNewsListViewPresenter_%ld", (long)index];
    return reuseId;
}

- (void)setupTableView {
    [super setupTableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor getColor:@"E6E6E6"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TTNewsListCell"];
    
    NSBundle *TTNewsBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"TTNewsBundle.bundle"]];

    [self.tableView registerNib:[UINib nibWithNibName:@"TTLayoutGroupPicCell" bundle:TTNewsBundle] forCellReuseIdentifier:groupPicCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"TTLayoutRightPicCell" bundle:TTNewsBundle] forCellReuseIdentifier:rightPicCellIdentifier];
    [self configTableViewPullUpDown];
}

- (void) configTableViewPullUpDown{
    __weak __typeof__(self) weakSelf = self;
    [self.tableView addPullToRefreshTypeDIY:^{
        [weakSelf requestNewest];
    }];
    [self.tableView addInfiniteScrolling:^{
        [weakSelf requestNext];
    }];
}

#pragma mark - Getter

- (TTNewsListRequest *)listRequest {
    if (!_listRequest) {
        _listRequest = [[TTNewsListRequest alloc] init];
        _listRequest.category = [self.channelUserInfo stringValueForKey:@"category"];
    }
    return _listRequest;
}

#pragma mark - Request data

- (void)requestPresenterData {
    [self handleRequest];
}

- (void) handleRequest{
    if (!_listRequest){//首次进入
        self.animatedForFirstLoad ? [self.tableView startRefreshing] : [self requestNewest];
    }else if (self.listResponse.data.count == 0){
        self.animatedForFirstLoad ? [self.tableView startRefreshing] : [self requestNewest];
    }else{
        self.tableView.tableFooterView = [UIView new];
        [self handlePullViews:YES count:self.listResponse.data.count];
    }
}

- (void)requestNewest {
    [self startListRequestForRefresh:YES];
}

- (void)requestNext {
    [self startListRequestForRefresh:NO];
}

- (void) startListRequestForRefresh:(BOOL)refresh {
    __weak typeof(self) weakSelf = self;
    
    self.listRequest.successCompletionBlock = ^(ZARPCBaseRequest *request) {
        NSDictionary *dict = request.responseObject;
        if (refresh) {
            weakSelf.listResponse = [TTNewsListResponse yy_modelWithDictionary:dict];
            
        } else {
            [weakSelf.listResponse appendContent:dict];
        }
        
        [weakSelf handlePullViews:refresh count:123234];
        [weakSelf.tableView reloadData];
    };
    
    self.listRequest.failureCompletionBlock = ^(ZARPCBaseRequest *request) {
        if (weakSelf.listResponse.data.count == 0) {
            weakSelf.tableView.tableFooterView = [UIView new];
            [weakSelf.tableView showErrorResetLoadingViewBlock:^{
                [weakSelf.tableView hideErrorResetLoadingView];
                [weakSelf.tableView showLoadingPanelView];
                [weakSelf requestNewest];
            }];
        }
        [weakSelf handlePullViews:refresh count:12342];
    };
    
    [self.listRequest start];
}

- (void) handlePullViews:(BOOL)isPulldown count:(NSInteger)count{
    if (isPulldown){
        [self.tableView pullDownDealFooterWithItemCount:count cursor:@"123"];
    }else{
        [self.tableView pullUpRefreshDealFooterWithItemCount:count cursor:@"123"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listResponse.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTNewsSummaryModel *model = [self.listResponse.data objectAtIndex:indexPath.row];
    if (model.infoModel.image_list.count == 3) {
        return 178;
    } else {
        return 124;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTNewsSummaryModel *model = [self.listResponse.data objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = nil;
    if (model.infoModel.image_list.count == 3) {
        TTLayoutGroupPicCell *groupPicCell = [tableView dequeueReusableCellWithIdentifier:groupPicCellIdentifier];
        [groupPicCell setContentWithModel:model.infoModel];
        cell = groupPicCell;
        
    } else {
        TTLayoutRightPicCell *rightPicCell = [tableView dequeueReusableCellWithIdentifier:rightPicCellIdentifier];
        [rightPicCell setContentWithModel:model.infoModel];
        cell = rightPicCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTNewsSummaryModel *model = [self.listResponse.data objectAtIndex:indexPath.row];
    TTNewsInfoModel *infoModel = model.infoModel;
    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:infoModel.article_url] userInfo:nil];
}

@end
