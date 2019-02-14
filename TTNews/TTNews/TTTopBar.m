//
//  TTTopBar.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTTopBar.h"

@interface TTTopBar()

@end

@implementation TTTopBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor getColor:@"D33D3D"];
        [self addSubview:self.bgImageView];
        [self addSubview:self.contentView];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self).offset(-5);
    }];
}

#pragma mark - Getter

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _bgImageView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(15, 32, KScreenWidth - 15, 40)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 3;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}



@end
