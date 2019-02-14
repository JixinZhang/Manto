//
//  TTNewsViewController.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTNewsViewController.h"
#import "TTNewsChannelResponse.h"
#import "TTNewsChannelRequest.h"
#import "TTTopBar.h"

@interface TTNewsViewController ()<TTChannelViewControllerDataSource, TTChannelViewControllerDelegate>

@property (nonatomic, strong) TTNewsChannelResponse *response;
@property (nonatomic, strong) TTNewsChannelRequest *request;

@property (nonatomic, strong) TTTopBar *topBar;

@end

@implementation TTNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupSubviews];
    [self requestChannels];
}

- (void)setupSubviews {
    self.dataSource = self;
    self.delegate = self;
    
    [self.view addSubview:self.topBar];
    [self.sectionView setViewFrameY:CGRectGetMaxY(self.topBar.frame)];
    self.sectionView.observerView = self.channelContentsView;
    [self.view addSubview:self.sectionView];
    [self.view addSubview:self.channelContentsView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self reloadCurrentPresenterForDisappear];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self reloadCurrentPresenterForAppear];
}

- (void)reloadCurrentPresenterForAppear {
    if (self.currentIndex >= 0 && self.currentIndex < self.response.channelItems.count) {
        TTNewsChannelItem *item = self.response.channelItems[self.currentIndex];
        id<TTChannelViewPresenterProtocol> presenter = item.presenter;
        [presenter viewWillPresent];
    }
}

- (void)reloadCurrentPresenterForDisappear {
    if (self.currentIndex >= 0 && self.currentIndex < self.response.channelItems.count) {
        TTNewsChannelItem *item = self.response.channelItems[self.currentIndex];
        id<TTChannelViewPresenterProtocol> presenter = item.presenter;
        [presenter viewDidEndPresenting];
    }
}

#pragma mark - Getter

- (TTNewsChannelRequest *)request {
    if (!_request) {
        _request = [[TTNewsChannelRequest alloc] init];
    }
    return _request;
}

- (TTTopBar *)topBar {
    if (!_topBar) {
        _topBar = [[TTTopBar alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KNavHeight + 6)];
    }
    return _topBar;
}

#pragma mark - Setter

- (void)setResponse:(TTNewsChannelResponse *)response {
    if (response.channelItems.count > 0) {
        if (![_response isEqual:response]) {
            _response = response;
        }
    }
    [self reloadChannels];
}

#pragma mark - Request

- (void)requestChannels {
    __weak __typeof__ (self)weakSelf = self;
    [self.request startWithCompletionBlockWithSuccess:^(ZARPCBaseRequest *request) {
        NSDictionary *data = [request.responseObject dictionaryValueForKey:@"data"];
        weakSelf.response = [[TTNewsChannelResponse alloc] initWithContent:data];
    } failure:^(ZARPCBaseRequest *request) {
        
    }];
}

- (void)reloadChannels {
    NSArray *sectionTitles = self.response.channelTitles;
    [self.sectionView setContents:sectionTitles];
    
    NSString *title = [self currentSectionTitle];
    [super reloadChannels];
    [self gotoChannel:title];
}

- (NSString *)currentSectionTitle {
    NSString *currentTitle = nil;
    if (self.sectionView.currentIndex < [self.sectionView.contents count]) {
        currentTitle = [self.sectionView.contents objectAtIndex:self.sectionView.currentIndex];
    }
    return currentTitle;
}

- (void)gotoChannel:(NSString *)title {
    NSArray *sectionTitle = self.response.channelTitles;
    NSInteger index = [sectionTitle indexOfObject:title];
    if (index != NSNotFound) {
        if ([self isViewLoaded] && self.sectionView) {
            [self.sectionView goToIndex:index];
        }
    }
}

- (CGRect)collectionViewFrame {
    return CGRectMake(0, CGRectGetMaxY(self.topBar.frame), KScreenWidth, CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.topBar.frame));
}

#pragma mark -- UICollectionViewDelegate

- (void)channelsViewControllerDidStill:(TTChannelViewController *)viewContoller {
    TTNewsChannelItem *item = self.response.channelItems[self.currentIndex];
    id<TTChannelViewPresenterProtocol> presenter = item.presenter;
    if ([presenter respondsToSelector:@selector(requestPresenterData)]) {
        [presenter requestPresenterData];
    }
}

- (NSInteger)numberOfChannelsInViewController:(TTChannelViewController *)viewController {
    return self.response.channelItems.count;
}

- (id<TTChannelViewPresenterProtocol>)presenterForChannelAtIndex:(NSInteger)index {
    if (index >= self.response.channelItems.count || index < 0) {
        return nil;
    }
    
    TTNewsChannelItem *item = self.response.channelItems[index];
    return item.presenter;
}

- (id<TTChannelViewPresenterProtocol>)channelViewController:(TTChannelViewController *)viewController presenterForChannelAtIndex:(NSInteger)index {
    if (index >= self.response.channelItems.count || index < 0) {
        return nil;
    }
    TTNewsChannelItem *item = self.response.channelItems[index];
    id<TTChannelViewPresenterProtocol> presenter = item.presenter;
    if ([presenter respondsToSelector:@selector(setController:)]) {
        [presenter performSelector:@selector(setController:) withObject:self];
    }
    
    return presenter;
}

- (void)tabbarItemClicked {
    [self reloadChannelAtIndex:self.sectionView.currentIndex];
}

@end
