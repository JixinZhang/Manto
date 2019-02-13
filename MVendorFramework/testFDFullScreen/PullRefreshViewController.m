//
//  PullRefreshViewController.m
//  MVendorFramework
//
//  Created by Micker on 16/9/19.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "PullRefreshViewController.h"
#import "MVendorFramework.h"
#import <ZANetwork/ZANetwork.h>
#import <ZANetwork/UIImage+MultiFormat.h>

#import "FullViewController.h"

static NSString *gPullRefreshImage;


@interface MNewsWebViewCollectionViewCell : UICollectionViewCell <UIWebViewDelegate>
@property (nonatomic, strong, readwrite) UIWebView *webView;

@end

@implementation MNewsWebViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self __setup];
    }
    return self;
}

- (void) __setup {
    
    {
        __weak __typeof__(self) weakSelf = self;
        [self addSubview:self.webView];
    }
}

- (void) dealloc {
    
}

#pragma mark --Getter

- (UIWebView *) webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _webView.delegate = self;
        ((UIView *)_webView).opaque = YES;
        ((UIView *)_webView).backgroundColor = [UIColor getColor:@"F6F6F6"];
        
        __weak typeof(self) weakSelf = self;
        

        [_webView.scrollView addPullToRefreshTypeDIY:^{
            [weakSelf.webView reload];
        }];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.baidu.com"]]];
    }
    return _webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [webView.scrollView stopAnimating];
//    [webView.scrollView.pullToRefreshView stopAnimating];
//    [webView.scrollView.infiniteScrollingView stopAnimating];
}


@end


@interface PullRefreshViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation PullRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    gPullRefreshImage = [[NSBundle mainBundle] pathForResource:@"dd5783ea731805211bafb3c3c8a30dd7" ofType:@"gif"];

//    [self.view addSubview:self.collectionView];
//    [SVPullToRefreshView appearance].animatedImage = @"path";
    NSLog(@"aaapath = %@", @"path");
//    [[NSNotificationCenter defaultCenter] postNotificationName:KSVPullToRefreshViewDataChanged object:@"path"];

    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(doneAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    FullViewController *controller = [[FullViewController alloc ] init];
    [self.navigationController pushViewController:controller animated:YES];

}


#pragma mark -- Getter

- (UICollectionView *) collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),
                                                                             CGRectGetHeight(self.view.bounds) - 113)
                                             collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        for (int i = 0 ; i < 10; i++) {
            [_collectionView registerClass:[MNewsWebViewCollectionViewCell class]
                forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@",@(i)]];
        }

    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *) flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout.headerReferenceSize = CGSizeZero;
        _flowLayout.footerReferenceSize = CGSizeZero;
        _flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)  - 113);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}


#pragma mark -- UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MNewsWebViewCollectionViewCell *cell = (MNewsWebViewCollectionViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@",@(indexPath.item)]
                                              forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


@end



@interface SVPullToRefreshView(GIF)

@end

@implementation SVPullToRefreshView(GIF)

- (void) reloadAnimatedImage {
    
    
//    NSData  *data = [NSData dataWithContentsOfFile:animatedImage];
//    UIImage *image = [UIImage sd_imageWithData:data];
//    self.animatedImageView.image = image;
//    
//    return;
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown__%zd", i]];
        [refreshingImages addObject:image];
    }

    
    [self.animatedImageView setAnimationImages:refreshingImages ];
    self.animatedImageView.animationDuration = 1.0f;
    
    [self.animatedImageView startAnimating];
    NSLog(@"animations = %@ image = %@ path = %@", [self.animatedImageView.layer animationKeys], self.animatedImageView.image, @"");

    return;
    
    
    //    if (0 == [[self.animatedImageView.layer animationKeys] count])
    {
        //        animatedImage = [[NSBundle mainBundle] pathForResource:@"dd5783ea731805211bafb3c3c8a30dd7" ofType:@"gif"];
        NSString * animatedImage = @"/Users/micker/Library/Developer/CoreSimulator/Devices/C3F8AC88-B9E1-464F-A803-D39C94C424B2/data/Containers/Data/Application/1BF1A6EC-D2F2-4D05-8678-478A7858C386/Library/Caches/default/com.hackemist.SDWebImageCache.default/dd5783ea731805211bafb3c3c8a30dd7.gif";
        animatedImage = gPullRefreshImage;
        NSData  *data = [NSData dataWithContentsOfFile:animatedImage];
        UIImage *image = [UIImage sd_imageWithData:data];
        self.animatedImageView.image = image;
        //        [self.animatedImageView startAnimating];
        
//        [self.animatedImageView.layer removeAllAnimations];
        NSLog(@"animations = %@ image = %@ path = %@", [self.animatedImageView.layer animationKeys], self.animatedImageView.image, @"");
    }
    
}

@end


@implementation PullRefreshFullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@" 确定" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(20, 100, 200, 40)];
    [button setBackgroundColor:[UIColor lightGrayColor]];
//    [button addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@" PULL" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(20, 150, 200, 40)];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(pullAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (IBAction)pullAction:(id)sender {
    PullRefreshViewController *controller = [[PullRefreshViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark --StatusBar

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}


@end
