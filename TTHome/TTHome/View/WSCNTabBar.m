//
//  WSCNTabBar.m
//  MHomeFramework
//
//  Created by AlexZhang on 2018/12/5.
//  Copyright © 2018 Micker. All rights reserved.
//

#import "WSCNTabBar.h"
#import "WSCNTabBarItem.h"
#import "WSCNTabBarItemModel.h"

@interface WSCNTabBar()

@property (nonatomic, strong) NSMutableArray<WSCNTabBarItem *> *itemArray;
@property (nonatomic, strong) NSArray<WSCNTabBarItemModel *> *dataArray;
@end

@implementation WSCNTabBar

- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof (self)weakSelf = self;
        [self ln_customThemeAction:^id{
            [weakSelf setShadowImage:[UIImage imageWithColor:[LNTheme colorForType:@"tabBarShadowC"] size:CGSizeMake(100, 0.25f)]];
            [weakSelf setBackgroundImage:[UIImage imageWithColor:[LNTheme colorForType:@"tabBarBgC"] size:CGSizeMake(100, 10)]];
            return nil;
        }];
    }
    return self;
}

#pragma mark - Getter

- (NSArray *)tabBarItemArray {
    return [self.itemArray copy];
}

#pragma mark - Setter

- (void)setTabBarController:(UITabBarController *)tabBarController {
    if (_tabBarController != tabBarController) {
        if (_tabBarController) {
            [self removeObserver];
        }
        _tabBarController = tabBarController;
        if (_tabBarController) {
            [_tabBarController addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:NULL];
        }
    }
}

- (void) removeObserver {
    [_tabBarController removeObserver:self forKeyPath:@"selectedIndex"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateItemsFrame];
}


- (void)updateItemsFrame {
    CGFloat itemWidth = (KScreenWidth/self.itemArray.count);
    CGFloat minX = 0; //(KScreenWidth - (71 * self.itemArray.count)) / 2.0;
    for (NSInteger index = 0; index < self.itemArray.count; index++) {
        WSCNTabBarItem *tabBarItem = [self.itemArray objectAtIndex:index];
        tabBarItem.frame = CGRectMake(minX + (itemWidth * index), -8, itemWidth, kWSCNTabBarItemHeight);
    }
}

- (void)setTabBarWithWithDatas:(NSArray *)datas {
    NSMutableArray<WSCNTabBarItemModel *> *mutaArray = [NSMutableArray arrayWithCapacity:datas.count];
    [datas enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)obj;
            WSCNTabBarItemModel *tabBarItemModel = [[WSCNTabBarItemModel alloc] init];
            [tabBarItemModel modelWithArray:array];
            if (tabBarItemModel) {
                [mutaArray addObject:tabBarItemModel];
            }
            
        } 
    }];
    self.dataArray = [mutaArray copy];
    
    if (self.dataArray.count > 0 &&
        self.itemArray.count == self.dataArray.count) {
        //数量相同，只需更新图片
        for (NSInteger index = 0; index < self.itemArray.count; index++) {
            WSCNTabBarItem *tabBarItem = [self.itemArray objectAtIndex:index];
            WSCNTabBarItemModel *tabbarItemModel = [self.dataArray objectAtIndex:index];
            if (index == self.selectedIndex) {
                tabBarItem.wscnSelected = YES;
            }
            [self addSubview:tabBarItem];
            [self updateWSCNTabBarWith:tabBarItem tabbarItemModel:tabbarItemModel];

        }
        
    } else {
        if (self.itemArray.count) {
            for (WSCNTabBarItem *tabBarItem in self.itemArray) {
                [tabBarItem removeFromSuperview];
            }
        }
        
        NSMutableArray<WSCNTabBarItem *> *mutaItemArray = [NSMutableArray arrayWithCapacity:self.dataArray.count];
        [self.dataArray enumerateObjectsUsingBlock:^(WSCNTabBarItemModel * _Nonnull tabbarItemModel, NSUInteger idx, BOOL * _Nonnull stop) {
            WSCNTabBarItem *tabBarItem = [[WSCNTabBarItem alloc] initWithFrame:CGRectMake(0, -8, 60, 49)];
            [tabBarItem addTarget:self action:@selector(tabBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            tabBarItem.tag = 10000 + idx;
            [self addSubview:tabBarItem];
            [mutaItemArray addObject:tabBarItem];
            [self updateWSCNTabBarWith:tabBarItem tabbarItemModel:tabbarItemModel];
        }];
        self.itemArray = [NSMutableArray arrayWithArray:[mutaItemArray copy]];
    }
}

- (void)updateWSCNTabBarWith:(WSCNTabBarItem *)tabBarItem tabbarItemModel:(WSCNTabBarItemModel *)tabbarItemModel {
    BOOL isDay = [[ThemeManager sharedInstance] isDay];
    __weak typeof (WSCNTabBarItem *) weakTabBarItem = tabBarItem;
    
    tabBarItem.showActivity = [tabbarItemModel.activity showActivity];
    if ([tabbarItemModel.activity showActivity]) {
        NSString *normalImageURLString = isDay ? tabbarItemModel.activity.normal : tabbarItemModel.activity.night_Normal;
        [tabBarItem downloadImage:normalImageURLString width:60 height:57 block:^(UIImage * _Nonnull image) {
            weakTabBarItem.normalImage = image;
        }];
        
        NSString *selectedImageURLString = isDay ? tabbarItemModel.activity.pressed : tabbarItemModel.activity.night_Pressed;
        [tabBarItem downloadImage:selectedImageURLString width:60 height:57 block:^(UIImage * _Nonnull image) {
            weakTabBarItem.selectedImage = image;
        }];
        
    } else {
        [tabBarItem setTitle:tabbarItemModel.label forState:UIControlStateNormal];
        
        NSString *normalImageURLString = isDay ? tabbarItemModel.normal : tabbarItemModel.night_Normal;
        [tabBarItem downloadImage:normalImageURLString width:60 height:57 block:^(UIImage * _Nonnull image) {
            [weakTabBarItem setImage:image forState:UIControlStateNormal];
        }];
        
        NSString *selectedImageURLString = isDay ? tabbarItemModel.pressed : tabbarItemModel.night_Pressed;
        [tabBarItem downloadImage:selectedImageURLString width:20 height:20 block:^(UIImage * _Nonnull image) {
            [weakTabBarItem setImage:image forState:UIControlStateSelected];
            [weakTabBarItem setImage:image forState:UIControlStateHighlighted];
        }];
        
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (selectedIndex > self.itemArray.count) {
        return;
    }
    
    WSCNTabBarItem *selectedTabBarItem = nil;
    for (NSInteger index = 0; index < self.itemArray.count; index++) {
        WSCNTabBarItem *tabBarItem = [self.itemArray objectAtIndex:index];
        tabBarItem.wscnSelected = NO;
        
        if (index == selectedIndex) {
            selectedTabBarItem = tabBarItem;
        }
    }
    selectedTabBarItem.wscnSelected = YES;
}

#pragma mark - Action

- (void)tabBarItemClicked:(WSCNTabBarItem *)tabBarItem {
    NSInteger tag = tabBarItem.tag - 10000;
    
    for (WSCNTabBarItem *item in self.itemArray) {
        item.wscnSelected = NO;
    }
    tabBarItem.wscnSelected = YES;
    
    
    if ([self.wscnDelegate respondsToSelector:@selector(wscnTabBarDidSelectedAtIndex:)]) {
        self.selectedIndex = tag;
        [self.wscnDelegate wscnTabBarDidSelectedAtIndex:tag];
    }
}

- (void)addBadgeViewWithTabbarIndex:(NSInteger)index {
    if (index < self.itemArray.count) {
        WSCNTabBarItem *tabBarItem = [self.itemArray objectAtIndex:index];
        if (![tabBarItem wscnIsNoticePointViewShown]) {
            UIOffset offset = UIOffsetMake(20, -12);
            [tabBarItem wscnSetNoticePointViewOffset:offset];
            [tabBarItem wscnShowNoticePointView];
        }
        
//        if (![tabBarItem wscnIsBadgeViewShown]) {
//            UIOffset offset = UIOffsetMake(20, -12);
//            [tabBarItem wscnSetBadgeViewOffset:offset];
//            [tabBarItem.wscnBadgeView setViewFrameHeight:10 + 2 * index];
//            [tabBarItem wscnShowBadgeViewWithBadgeValue:@"99"];
//        }
    }
}

- (void)removeBageViewWithTabbarIndex:(NSInteger)index {
    if (index < self.itemArray.count) {
        WSCNTabBarItem *tabBarItem = [self.itemArray objectAtIndex:index];
        [tabBarItem wscnHideNoticePointView];;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectedIndex"]) {
        if (self.selectedIndex != self.tabBarController.selectedIndex) {
            self.selectedIndex = self.tabBarController.selectedIndex;
        }
    }
}

@end
