//
//  BaseCollectionViewPresenter.h
//  GoldBaseFramework
//
//  Created by hushaohua on 2017/5/3.
//  Copyright © 2017年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewPresenter.h"

@interface BaseCollectionViewPresenter : BaseViewPresenter<UICollectionViewDelegate, UICollectionViewDataSource>

/*!
 */
@property (nonatomic, weak) UICollectionView         *collectionView;

/*!
 */
@property (nonatomic, weak) UIViewController    *controller;

/*!
 */
@property (nonatomic, strong) NSArray    *contents;


- (instancetype)initWithController:(UIViewController *) controller;


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView controller:(UIViewController *) controller;

- (void) setupCollectionView;


- (void) doSetContentData:(id) content;

@end
