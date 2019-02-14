//
//  GoldSectionView.h
//  GoldSectionFramework
//
//  Created by Micker on 16/5/22.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger , GOLD_SECTION_ANIMATE_TYPE) {
    GOLD_SECTION_ANIMATE_TEXT_COLOR = 1 << 0,       //文本颜色
    GOLD_SECTION_ANIMATE_TEXT_TRANSFORM = 1 << 1,   //文本变换
    GOLD_SECTION_ANIMATE_INDICATOR_ALPHA = 1 << 2,  //指示条透明度
    GOLD_SECTION_ANIMATE_INDICATOR_SNAKE = 1 << 3,  //指示条蛇形增长
    GOLD_SECTION_ANIMATE_INDICATOR_ANCHOR = 1 << 4, //锚点，文本居中，与SNAKE互斥

    GOLD_SECTION_ANIMATE_DEFAULT =                  //默认值
    GOLD_SECTION_ANIMATE_TEXT_COLOR |
//    GOLD_SECTION_ANIMATE_TEXT_TRANSFORM |
    GOLD_SECTION_ANIMATE_INDICATOR_ALPHA |
    GOLD_SECTION_ANIMATE_INDICATOR_SNAKE |
    GOLD_SECTION_ANIMATE_INDICATOR_ANCHOR,
};

@class GoldSectionView;

@protocol GoldSectionViewProtocol <NSObject>

- (void) sectionView:(GoldSectionView *)sectionView currrentIndexChanged:(NSInteger) index;

- (void) sectionView:(GoldSectionView *)sectionView didSelectSectionAtIndex:(NSInteger)index;

@optional
- (void) sectionViewDidScroll:(GoldSectionView *)sectionView;

@end


@protocol GoldSectionViewDataSource <NSObject>

- (CGFloat) widthAtIndex:(NSInteger) index;

- (void) customCell:(UICollectionViewCell *) cell index:(NSInteger) index;

@end

@interface GoldSectionView : UIView<UIAppearance>

@property(nonatomic, readonly) UIScrollView* scrollView;

@property (nonatomic, copy) NSArray               *contents;
@property (nonatomic, strong) NSArray               *redDotIndexArray;
@property (nonatomic, assign, readonly) NSUInteger  currentIndex;
@property (nonatomic, strong, readonly) UIView      *indicatorLineView;
@property (nonatomic, strong) UIScrollView          *observerView;
@property (nonatomic, weak) id<GoldSectionViewProtocol> delegate;
@property (nonatomic, weak) id<GoldSectionViewDataSource> datasource;
@property (nonatomic, assign) GOLD_SECTION_ANIMATE_TYPE animateType;
@property (nonatomic, assign) CGFloat               indicatorBottompPadding;        //default is 5.0
@property (nonatomic, assign) CGSize                anchorSize UI_APPEARANCE_SELECTOR;  // defalut size is (17,3)
@property (nonatomic, strong) UIFont                *cellFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont                *selectedCellFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor               *indicatorBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat               padding;        //default is 16.0
@property (nonatomic, assign) NSInteger             secionPerPage;  //once set , the padding will changed, used for equal padding, it might be changed ,if the contents count is less than the origin data
@property (nonatomic) BOOL averageWidthPaging;
@property (nonatomic) CGFloat pageWidth; //default is size.width
@property (nonatomic) CGFloat indicatorEdge; //indicator edge

@property(nonatomic) BOOL scrollImmediatelyWhenSectionlNotAppeared;//当obserview对应的section不在显示区域,是否立刻滚动到改区域

@property (nonatomic, copy)  void (^block)(NSInteger);

- (void) setColors:(NSArray *) colors UI_APPEARANCE_SELECTOR; //update colors with reloadData
- (void) setTextBackgroundColors:(NSArray *)colors;//update backgroundColors with reloadData
- (void) updateTextColors:(NSArray *)colors;//update colors without reloadData

- (void) reloadData;

- (void) goToIndex:(NSUInteger) index;
- (void) setSectionViewIndex:(NSUInteger) index;

- (void) scrollCurrentIndexAtMiddle;

- (void) setNeedsLayoutIndicator;
- (void)updateIndicatorPositionWithIndex:(NSInteger)index animation:(BOOL)animation;
#pragma mark -- deprecated

- (void) beforColor:(UIColor *) befor after:(UIColor *) after __deprecated_msg("use setColors to sepcial the two colors");

- (void) layoutContentView;

@end
