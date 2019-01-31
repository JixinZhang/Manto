//
//  BaseCollectionViewController.h
//  GoldBaseFramework
//
//  Created by hushaohua on 2017/5/3.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate>{
    UICollectionViewLayout* _collectionViewLayout;
}

@property (nonatomic, strong) id presenter;


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;


- (CGRect) doGetCollectionViewFrame;


@end
