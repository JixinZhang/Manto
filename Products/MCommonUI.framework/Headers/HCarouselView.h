//
//  HCarouselView.h
//  HPayablePostFramework
//
//  Created by hushaohua on 9/26/16.
//  Copyright © 2016 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPagesIndicator.h"
#import "HTextPageIndicator.h"

@class HCarouselView;
@protocol HCarouselViewDelegate <NSObject>

- (NSString *) cellReuseIdForIndex:(NSInteger)index;
- (void) carouselView:(HCarouselView *)carouselView configCell:(UICollectionViewCell *)cell forItemAtIndex:(NSInteger)index;

- (NSInteger) numberOfItemInCarouselView:(HCarouselView *)carouselView;
@optional
- (void) carouselView:(HCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index;
- (void) carouselView:(HCarouselView *)carouselView willDisplayCell:(UICollectionViewCell *)cell atIndex:(NSInteger)index;
- (void) carouselView:(HCarouselView *)carouselView didEndDisplayCell:(UICollectionViewCell *)cell atIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, HCarouselPageIndicator){
    HCarouselPageIndicatorDot,
    HCarouselPageIndicatorText
};

@interface HCarouselViewLayout : NSObject

@property(nonatomic) UIEdgeInsets contentInsets;

@property(nonatomic) CGFloat marginToSuperForItemWhenHorizontalCenter;//居中的item左右的间距
@property(nonatomic) CGFloat itemsSpace;

@property(nonatomic) BOOL pagingEnabled; //pagingEnabled==YES
@property(nonatomic) BOOL showPageControl;

@property(nonatomic) HCarouselPageIndicator indicatorStyle;

@property(nonatomic) BOOL indicatorEmbed;

@end

@interface HCarouselView : UIView

- (id) initWithFrame:(CGRect)frame layout:(HCarouselViewLayout *)layout;
@property(nonatomic, weak) id<HCarouselViewDelegate> delegate;
@property(nonatomic, strong,readonly) UICollectionView* contentCollectionView;
@property(nonatomic, strong) UIView* backgroundView;

@property(nonatomic) BOOL timingCarousel;
- (void) startTimer;
- (void) stopTimer;

#pragma mark - register
- (void) registerCollectionViewCellWithClass:(Class)cellClass withReuseId:(NSString *)reuseId;
- (void) registerCollectionViewCellWithNib:(UINib *)nib withReuseId:(NSString *)reuseId;

#pragma mark - index

- (NSInteger) currentIndex;
- (void) scrollToIndex:(NSInteger)index;
- (UICollectionViewCell *) collectionViewCellAtIndex:(NSInteger)index;
- (void) scrollViewDidScroll:(UIScrollView *)scrollView;
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView;

#pragma mark - reload
- (void) reloadData;
- (void) reloadItemAtIndex:(NSInteger)index;
- (void)updateSubViewsFrame;

#pragma mark - iindicator

@property(nonatomic, readonly) id<HPageIndicatorProtocol> pageControl;

- (HPagesIndicator *) dotPageController;
- (HTextPageIndicator *) textPageController;

@end
