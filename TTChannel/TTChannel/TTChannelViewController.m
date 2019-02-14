//
//  TTChannelViewController.m
//  TTChannel
//
//  Created by AlexZhang on 2019/2/13.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTChannelViewController.h"
#import "TTChannelCollectionViewCell.h"

#pragma mark -
#pragma mark - TTChannelFlowLayout

@interface TTChannelFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger page;

@end

@implementation TTChannelFlowLayout

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    return CGPointMake(self.page * self.collectionView.frame.size.width, 0);
    
}

#pragma mark -
#pragma mark - TTChannelViewController

@end

@interface TTChannelViewController ()<UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) GoldSectionView* sectionView;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) TTChannelFlowLayout* collectionViewFlowLayout;

@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, assign) CGSize collectionViewCellSize;
@property (nonatomic, assign) BOOL isStartingRotate;

@property (nonatomic, assign) NSInteger rotateIndex;


@end

@implementation TTChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rotateIndex = NSNotFound;
    self.statusBarStyle = [ThemeManager sharedInstance].isDay ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSInteger count = [self.dataSource numberOfChannelsInViewController:self];
    for (int i = 0; i < count; i++) {
        id<TTChannelViewPresenterProtocol>presenter = [self.dataSource channelViewController:self presenterForChannelAtIndex:i];
        if ([presenter conformsToProtocol:@protocol(TTChannelViewPresenterProtocol)] &&
            [presenter respondsToSelector:@selector(closeVideoPlayer)]) {
            [presenter closeVideoPlayer];
        }
    }
}

- (UIView *)channelTitlesView {
    return self.sectionView;
}

- (UIScrollView *)channelContentsView {
    return self.collectionView;
}

- (GoldSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[GoldSectionView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds) - 60, 44)];
        _sectionView.cellFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _sectionView.secionPerPage = 6;
        [_sectionView setColors:@[[UIColor getColor:@"333333"], [UIColor redColor]]];
        _sectionView.delegate = self;
        _sectionView.indicatorLineView.hidden = YES;
    }
    return _sectionView;
}

- (UICollectionView *) collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[self collectionViewFrame] collectionViewLayout:self.collectionViewFlowLayout];
        
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.allowsSelection = NO;
    }
    return _collectionView;
}

- (TTChannelFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [[TTChannelFlowLayout alloc] init];
        _collectionViewFlowLayout.minimumLineSpacing = 0;
        _collectionViewFlowLayout.minimumInteritemSpacing = 0;
        _collectionViewFlowLayout.sectionInset = UIEdgeInsetsZero;
        _collectionViewFlowLayout.headerReferenceSize = CGSizeZero;
        _collectionViewFlowLayout.footerReferenceSize = CGSizeZero;
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _collectionViewFlowLayout;

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    NSUInteger curIndex = (_collectionView.contentOffset.x + CGRectGetWidth(self.view.bounds) / 2) / CGRectGetWidth(self.view.bounds);
    _collectionViewFlowLayout.page = curIndex;
    
    if (kDevice_Is_EnableRotate) {
        self.rotateIndex = curIndex;
        [_collectionViewFlowLayout invalidateLayout];
        self.isStartingRotate = YES;
        
        NSInteger count = [self.dataSource numberOfChannelsInViewController:self];
        for (NSInteger i = 0; i < count; i++) {
            id<TTChannelViewPresenterProtocol> presenter = [self.dataSource channelViewController:self presenterForChannelAtIndex:i];
            if ([presenter respondsToSelector:@selector(rotateScreenAlready)]) {
                presenter.rotateScreenAlready = YES;
            }
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(KScreenWidth, KScreenHeight - KNavHeight - KtabBarHeight);
}

- (void)reloadChannels {
    [self registerCells];
    [_collectionView reloadData];
    [_sectionView reloadData];
}

- (void)registerCells {
    NSInteger count = [self.dataSource numberOfChannelsInViewController:self];
    for (NSInteger idx = 0; idx < count; idx++) {
        id<TTChannelViewPresenterProtocol> presenter = [self.dataSource channelViewController:self presenterForChannelAtIndex:idx];
        if ([presenter respondsToSelector:@selector(collectionViewCellClass)]) {
            [self.collectionView registerClass:[presenter collectionViewCellClass] forCellWithReuseIdentifier:[self reuseIdForPresenter:presenter index:idx]];
        }
    }
}

- (NSString *)reuseIdForPresenter:(id<TTChannelViewPresenterProtocol>)presenter index:(NSInteger)index{
    NSString* reuseId = NSStringFromClass([presenter class]);
    if ([presenter respondsToSelector:@selector(collectionReuseIdAtIndex:)]){
        reuseId = [presenter collectionReuseIdAtIndex:index];
        
    }else if ([presenter respondsToSelector:@selector(collectionReuseId)]){
        reuseId = [presenter collectionReuseId];
        
    }
    return reuseId;
}

- (void)reloadChannelAtIndex:(NSInteger)index {
    if (index >= 0 && index < [self.dataSource numberOfChannelsInViewController:self]) {
        id<TTChannelViewPresenterProtocol> presenter = [self.dataSource channelViewController:self presenterForChannelAtIndex:index];
        if ([presenter respondsToSelector:@selector(reloadChannelContent:)]) {
            [presenter reloadChannelContent:YES];
        }
    }
}

- (CGRect)collectionViewFrame {
    return self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfChannelsInViewController:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<TTChannelViewPresenterProtocol> presenter = [self.dataSource channelViewController:self presenterForChannelAtIndex:indexPath.item];
    NSString *reuseId = [self reuseIdForPresenter:presenter index:indexPath.item];
    TTChannelCollectionViewCell *cell = (TTChannelCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    NSInteger count = [self.dataSource numberOfChannelsInViewController:self];
    for (NSInteger i = 0; i < count; i++) {
        id<TTChannelViewPresenterProtocol> presenter = [self.dataSource channelViewController:self presenterForChannelAtIndex:i];
        if ([presenter conformsToProtocol:@protocol(TTChannelViewPresenterProtocol)] &&
            [presenter respondsToSelector:@selector(closeVideoPlayer)]) {
            [presenter closeVideoPlayer];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(channelsViewControllerDidStill:)]) {
        [self.delegate channelsViewControllerDidStill:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.currentIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
        if ([self.delegate respondsToSelector:@selector(channelsViewControllerDidStill:)]) {
            [self.delegate channelsViewControllerDidStill:self];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id<TTChannelViewPresenterProtocol> presenter = [self.dataSource channelViewController:self presenterForChannelAtIndex:indexPath.item];
    self.currentIndex = indexPath.item;
    [(TTChannelCollectionViewCell *)cell setChannelViewPresenter:presenter];
    if ([self.delegate respondsToSelector:@selector(channelsViewController:willPresentChannel:)]) {
        [self.delegate channelsViewController:self willPresentChannel:indexPath.item
         ];
    }
    
    if (!self.collectionView.isDragging && !self.collectionView.isDecelerating) {
        [self.delegate channelsViewControllerDidStill:self];
    }
    
    [presenter viewWillPresent];
}

- (id<TTChannelViewPresenterProtocol>)presenterForChannelAtIndex:(NSInteger)index {
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(channelsViewController:didEndPresentingChannel:)]){
        [self.delegate channelsViewController:self didEndPresentingChannel:indexPath.item];
    }
    
    id<TTChannelViewPresenterProtocol> presenter = [self presenterForChannelAtIndex:indexPath.item];
    [presenter viewDidEndPresenting];
}

- (void) sectionView:(GoldSectionView *)sectionView currrentIndexChanged:(NSInteger) index{
    
}

- (void) sectionView:(GoldSectionView *)sectionView didSelectSectionAtIndex:(NSInteger)index{
    
}

@end
