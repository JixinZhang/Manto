//
//  TTBaseWebViewController.m
//  TTWebView
//
//  Created by AlexZhang on 2019/2/15.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTBaseWebViewController.h"

@interface TTBaseWebViewController ()<WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, strong) NSURL *requestURL;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation TTBaseWebViewController{
    CGFloat _lastWebViewContentHeight;
    CGFloat _lastTableViewContentHeight;
}

- (void)dealloc {
//    [self removeObservers];
}

- (void)handleRouterLink:(MRouterLink *)link {
    self.requestURL = link.URL;
    [self loadDefaultRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initValue];
    [self initView];
//    [self addObservers];
    
//    NSString *urlString = @"https://m.wallstreetcn.com/vip/articles/3463620"; //@"https://m.wallstreetcn.com/livenews/1427697"
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    [self.wkWebView loadRequest:request];
    
    [self loadDefaultRequest];
    
}

- (void) loadDefaultRequest {
    if (self.requestURL && [self isViewLoaded]) {
        [self.view.indicatorView startAnimating];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestURL];
        [self.wkWebView loadRequest:request];
    }
}

- (void)initValue{
    _lastWebViewContentHeight = 0;
    _lastTableViewContentHeight = 0;
}

- (void)initView{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    [self.navigationItem setLeftBarButtonItems:@[backItem]];
    
    [self.view addSubview:self.wkWebView];

    
//    [self.contentView addSubview:self.wkWebView];
//    [self.contentView addSubview:self.tableView];
//
//    [self.view addSubview:self.containerScrollView];
//    [self.containerScrollView addSubview:self.contentView];
//
//    self.contentView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight * 2);
    CGRect wkWebViewFrame = self.wkWebView.frame;
    self.wkWebView.frame = CGRectMake(wkWebViewFrame.origin.x, 0, wkWebViewFrame.size.width, wkWebViewFrame.size.height);
//    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.wkWebView.frame), KScreenWidth, KScreenHeight - KNavHeight);
}

#pragma mark - Getter

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - KNavHeight)];
        _containerScrollView.delegate = self;
        _containerScrollView.backgroundColor = [UIColor redColor];
        _containerScrollView.alwaysBounceVertical = YES;
    }
    return _containerScrollView;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 0, KScreenHeight - KNavHeight) configuration:[self configuration]];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
//        _wkWebView.scrollView.scrollEnabled = NO;
        _wkWebView.scrollView.delegate = self;
//        _wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _wkWebView;
}

- (WKWebViewConfiguration *) configuration {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    return configuration;
}

- (WKUserContentController *) webViewUserContentController{
    WKUserContentController* contentController = [[WKUserContentController alloc] init];
    return contentController;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.view.indicatorView stopAnimating];
    self.title = webView.title;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_containerScrollView != scrollView) {
        return;
    }
    
    CGPoint offset = scrollView.contentOffset;
    CGFloat offsetY = offset.y;
//    NSLog(@"offsetY = %.2f", offsetY);
    
    
    CGFloat webViewHeight = CGRectGetHeight(self.wkWebView.frame);
    CGFloat tableViewHeight = CGRectGetHeight(self.tableView.frame);
    
    CGFloat webViewContentHeight = self.wkWebView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    
    if (offsetY <= 0) {
        [self.contentView setViewFrameY:0];
        self.wkWebView.scrollView.contentOffset = CGPointZero;
        self.tableView.contentOffset = CGPointZero;

    }else if(offsetY < webViewContentHeight - webViewHeight){
        [self.contentView setViewFrameY:offsetY];
        self.wkWebView.scrollView.contentOffset = CGPointMake(0, offsetY);
        self.tableView.contentOffset = CGPointZero;

    }else if(offsetY < webViewContentHeight){
        [self.contentView setViewFrameY:webViewContentHeight - webViewHeight];
        self.wkWebView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointZero;

    }else if(offsetY < webViewContentHeight + tableViewContentHeight - tableViewHeight){
        [self.contentView setViewFrameY:offsetY - webViewHeight];
        self.tableView.contentOffset = CGPointMake(0, offsetY - webViewContentHeight);
        self.wkWebView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);

    }else if(offsetY <= webViewContentHeight + tableViewContentHeight ){
        [self.contentView setViewFrameY:self.containerScrollView.contentSize.height - self.contentView.height];
        self.wkWebView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);

    }else {
        //do nothing
        NSLog(@"do nothing");
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark - UITableViewDataSouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor redColor];
    }
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark - Observers

- (void)addObservers{
    [self.wkWebView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers{
    [self.wkWebView removeObserver:self forKeyPath:@"scrollView.contentSize"];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _wkWebView) {
        if ([keyPath isEqualToString:@"scrollView.contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }else if(object == _tableView) {
        if ([keyPath isEqualToString:@"contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }
}

- (void)updateContainerScrollViewContentSize:(NSInteger)flag webViewContentHeight:(CGFloat)inWebViewContentHeight{
    
    CGFloat webViewContentHeight = flag==1 ? inWebViewContentHeight : self.wkWebView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    
    if (webViewContentHeight == _lastWebViewContentHeight && tableViewContentHeight == _lastTableViewContentHeight) {
        return;
    }
    
    _lastWebViewContentHeight = webViewContentHeight;
    _lastTableViewContentHeight = tableViewContentHeight;
    
    self.containerScrollView.contentSize = CGSizeMake(self.view.width, webViewContentHeight + tableViewContentHeight);
    
    CGFloat webViewHeight = (webViewContentHeight < self.view.height) ?webViewContentHeight :self.view.height ;
    CGFloat tableViewHeight = tableViewContentHeight < self.view.height ?tableViewContentHeight :self.view.height;
    [self.wkWebView setViewFrameHeight:webViewHeight <= 0.1 ?0.1 :webViewHeight];
    [self.contentView setViewFrameHeight:webViewHeight + tableViewHeight];
    [self.tableView setViewFrameHeight:tableViewHeight];
    [self.tableView setViewFrameY:CGRectGetMaxY(self.wkWebView.frame)];
    
    //Fix:contentSize变化时需要更新各个控件的位置
    [self scrollViewDidScroll:self.containerScrollView];
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _backBtn.frame = CGRectMake(0, 0, 32, 44);
        _backBtn.backgroundColor = [UIColor clearColor];
        _backBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 0);
        _backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:20];
        _backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_backBtn setTitle:@"\U0000e77b" forState:UIControlStateNormal];
        [_backBtn ln_titleColor:@"naviTintC" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _closeBtn.frame = CGRectMake(0, 0, 32, 44);
        _closeBtn.backgroundColor = [UIColor clearColor];
        _closeBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 0);
        _closeBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:20];
        _closeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_closeBtn setTitle:@"\U0000e77a" forState:UIControlStateNormal];
        [_closeBtn ln_titleColor:@"naviTintC" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (IBAction)actionBack:(id)sender {
    [self updateNavigationItemLeftBarButtonItemsWith:[self.wkWebView canGoBack]];
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    } else {
        [super actionBack:sender];
    }
}

- (IBAction)backAction:(id)sender {
    [self.wkWebView stopLoading];
    [self.view.indicatorView stopAnimating];
//    [self.wkWebView.scrollView endRefreshing];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateNavigationItemLeftBarButtonItemsWith:(BOOL) canGoBack {
    if (canGoBack) {
        if ([self.navigationItem leftBarButtonItems].count <= 1) {
            [self.backBtn setViewFrameWidth:32];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
            UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeBtn];
            [self.navigationItem setLeftBarButtonItems:@[backItem, closeItem]];
        }
    } else {
        [self.backBtn setViewFrameWidth:44];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
        [self.navigationItem setLeftBarButtonItems:@[backItem]];
    }
}

@end
