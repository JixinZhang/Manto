//
//  WSCNTabBarItem.m
//  MHomeFramework
//
//  Created by AlexZhang on 2018/12/5.
//  Copyright © 2018 Micker. All rights reserved.
//

#import "WSCNTabBarItem.h"

@interface WSCNTabBarItem()

@property (nonatomic, strong) UIImageView *activityImageView;

@end

@implementation WSCNTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self insertSubview:self.activityImageView aboveSubview:self.titleLabel];
    [self insertSubview:self.backgroundView belowSubview:self.activityImageView];
    
    [self setTitleColor:[UIColor getColor:@"999999"] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor getColor:@"1482F0"] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor getColor:@"1482F0"] forState:UIControlStateHighlighted];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    
    if (@available(iOS 8.2, *)) {
        self.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    }
    
//    __weak __typeof__ (self) weakSelf = self;
//    [LNTheme ln_customThemeAction:^id{
//        if ([ThemeManager sharedInstance].isDay) {
//
//        } else {
//
//        }
//        return nil;
//    }];
}

#pragma mark - Getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 8)];
        [_backgroundView ln_backgroundColor:@"tabBarBgC"];
        _backgroundView.userInteractionEnabled = NO;
        _backgroundView.hidden = YES;
    }
    return _backgroundView;
}

- (UIImageView *)activityImageView {
    if (!_activityImageView) {
        _activityImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - kWSCNTabBarItemWidth) / 2.0, 0, kWSCNTabBarItemWidth, kWSCNTabBarItemHeight)];
        _activityImageView.tag = 10002;
        _activityImageView.userInteractionEnabled = NO;
        _activityImageView.hidden = YES;
    }
    return _activityImageView;
}

#pragma mark - Setter

- (void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
    if (!self.wscnSelected) {
        self.activityImageView.image = normalImage;
    }
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    if (self.wscnSelected) {
        self.activityImageView.image = selectedImage;
    }
}

- (void)setWscnSelected:(BOOL)wscnSelected {
    _wscnSelected = wscnSelected;
    self.selected = wscnSelected;
    if (wscnSelected) {
        self.activityImageView.image = self.selectedImage;
    } else {
        self.activityImageView.image = self.normalImage;
    }
}

- (void)setShowActivity:(BOOL)showActivity {
    if (showActivity) {
        self.activityImageView.hidden = self.backgroundView.hidden = NO;
        [self bringSubviewToFront:self.activityImageView];
    } else {
        self.activityImageView.hidden = self.backgroundView.hidden = YES;
    }
}

#pragma mark - update frame

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 34 + 8, self.frame.size.width, 12);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (kDevice_IPhoneXSeries) {
        return CGRectMake(self.frame.size.width/2 - 10, 9 + 8, 20, 20);
    } else {
        return CGRectMake(self.frame.size.width/2 - 11, 8 + 8, 22, 22);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = CGRectMake(0, 8, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 8);
    self.activityImageView.frame = CGRectMake((CGRectGetWidth(self.frame) - kWSCNTabBarItemWidth) / 2.0, 0, kWSCNTabBarItemWidth, kWSCNTabBarItemHeight);
}

#pragma mark - download image

- (void) downloadImage:(NSString *)image
                 width:(NSInteger)width
                height:(NSInteger)height
                 block:(void(^)(UIImage *image)) block
{
    //    __weak typeof(self) weakSelf = self;
    if ([[image lowercaseString] hasPrefix:@"http"]) {
        NSString *imageString = [NSString stringWithFormat:@"%@?imageView2/1/h/%ld/w/%ld/q/100",image,(long)(height * [UIScreen mainScreen].scale), (long)(width * [UIScreen mainScreen].scale)];
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:imageString]
                                                    options: SDWebImageRetryFailed | SDWebImageContinueInBackground | SDWebImageHighPriority
                                                   progress:nil
                                                  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL)
         {
             
             if (!error && image) {
                 UIImage *scaledImage = image;
                 scaledImage = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
                 scaledImage = [scaledImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     !block?:block(scaledImage);
                 });
             }
         }];
    }
    else {
        !block?:block([UIImage imageNamed:image]);
    }
}

@end
