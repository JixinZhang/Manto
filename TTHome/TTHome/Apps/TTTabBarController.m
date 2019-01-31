//
//  TTTabBarController.m
//  TTHome
//
//  Created by AlexZhang on 2019/1/31.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTTabBarController.h"
#import "TTHomeTabResource.h"
#import "TTOnTabServiceImpl.h"
#import "WSCNTabBar.h"

#pragma mark -
#pragma mark - UIViewController+TabBarItemDoubleClicked

@interface UIViewController(TabBarItemDoubleClicked) <TabBarItemClickedProtocol>

- (void)tabBarItemClicked;

@end

@implementation UIViewController(TabBarItemDoubleClicked)

- (void) tabBarItemClicked {
    
}

- (void)networkChangeRefreshData {
    
}

- (void)enterForegroundAutoRefresh {
    
}

@end

#pragma mark -
#pragma mark - TTTabBarController

@interface TTTabBarController () <UITabBarDelegate, WSCNTabBarDelegate, UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableDictionary *tabItems;
@end

@implementation TTTabBarController {
    NSTimeInterval _distance;
    WSCNTabBar *_tabBar;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:NULL];
        
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(networkChanged:)
                                                         name:AFNetworkingReachabilityDidChangeNotification
                                                       object:nil];
        }
        
        _distance = [[NSDate date] timeIntervalSince1970];
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabBar = [[WSCNTabBar alloc] init];
    _tabBar.wscnDelegate = self;
    _tabBar.tabBarController = self;
    [self setValue:_tabBar forKey:@"tabBar"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadView {
    [super loadView];
    self.oldSelectedIndex = -1;
    self.tabItems = [NSMutableDictionary dictionaryWithCapacity:4];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    __weak __typeof(self) weakSelf = self;
    self.delegate = (id)weakSelf;
    //    self.tabBar.delegate = weakSelf;
    [self ln_customThemeAction:^id{
        [weakSelf.tabBar setShadowImage:[UIImage imageWithColor:[LNTheme colorForType:@"tabBarShadowC"] size:CGSizeMake(100, 0.25f)]];
        [weakSelf.tabBar setBackgroundImage:[UIImage imageWithColor:[LNTheme colorForType:@"tabBarBgC"] size:CGSizeMake(100, 10)]];
        return nil;
    }];
    DEBUGLOG(@"MTabBarController loadview");
}

- (void)setTabBarWithWithDatas:(NSArray *)datas {
    [_tabBar setTabBarWithWithDatas:datas];
}

#pragma mark --StatusBar

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return [[ThemeManager sharedInstance] isDay] ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
    self.navigationItem.titleView = viewController.navigationItem.titleView;
    self.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
    if (self.oldSelectedIndex == tabBarController.selectedIndex) {
        [self triggerRefresh:viewController];
    } else {
        self.oldSelectedIndex = tabBarController.selectedIndex;
    }
    _tabBar.selectedIndex = tabBarController.selectedIndex;
}

- (void) triggerRefresh:(UIViewController *) viewController {
    UIViewController *targetViewController = viewController;
    if ([targetViewController isKindOfClass:[UINavigationController class]]) {
        targetViewController = [[((UINavigationController *) viewController) viewControllers] firstObject];
    }
    [targetViewController tabBarItemClicked];
}

- (void) networkChangeRefresh:(UIViewController *) viewController {
    UIViewController *targetViewController = viewController;
    if ([targetViewController isKindOfClass:[UINavigationController class]]) {
        targetViewController = [[((UINavigationController *) viewController) viewControllers] firstObject];
    }
    [targetViewController networkChangeRefreshData];
}

- (void) enterForegroundRefresh:(UIViewController *) viewController {
    UIViewController *targetViewController = viewController;
    if ([targetViewController isKindOfClass:[UINavigationController class]]) {
        targetViewController = [[((UINavigationController *) viewController) viewControllers] firstObject];
    }
    [targetViewController enterForegroundAutoRefresh];
}

#pragma mark -- NetWorkStatus

- (void) networkChanged:(NSNotification *)notification {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        [self networkChangeRefresh:self.selectedViewController];
    }
}

#pragma mark -- willEnterForegroundNotification

- (void) willEnterForegroundNotification:(NSNotification *) notification {
    if ([[NSDate date] timeIntervalSince1970] - _distance >= 600) {
        _distance = [[NSDate date] timeIntervalSince1970];
        [self enterForegroundRefresh:self.selectedViewController];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *lastShowBadgeTI = [userDefaults objectForKey:@"TabbarWorthBadgeTimesTamps"];
    
    NSDate *date = [NSDate date];
    double timeInterval = date.timeIntervalSince1970;
    
    if (timeInterval - lastShowBadgeTI.doubleValue > 60 * 60) {
    }
    id<TTOnTabService> onTabService = [[BGServiceManager sharedInstance] findServiceByName:@"OnTabService"];
    [onTabService refreshTabbarBadge];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (kDevice_Is_EnableRotate) {
        
        __weak __typeof__(self) weakSelf = self;
        [coordinator animateAlongsideTransitionInView:self.view
                                            animation:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context)
         {
             
             
         }
                                           completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context)
         {
             
         }];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

#pragma mark - WSCNTabBarDelegate

- (void)wscnTabBarDidSelectedAtIndex:(NSInteger)index {
    self.selectedIndex = index;
    NSArray<UIViewController *> *viewControllers = self.viewControllers;
    [self tabBarController:self didSelectViewController:viewControllers[index]];
    
    if (index == 4) {
        [self resetBadgeValue];
    }
}

- (void)addBadgeViewWithTabbarIndex:(NSInteger)index {
    [_tabBar addBadgeViewWithTabbarIndex:index];
}

- (void)removeBageViewWithTabbarIndex:(NSInteger)index {
    [_tabBar removeBageViewWithTabbarIndex:index];
}

#pragma mark - Worth tabbar badge report

- (void)resetBadgeValue {
    [[TTHomeTabResource sharedTabResource] updateTabBagde:0];
}

@end
