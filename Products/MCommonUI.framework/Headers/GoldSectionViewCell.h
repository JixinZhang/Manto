//
//  GoldSectionViewCell.h
//  GoldSectionFramework
//
//  Created by Micker on 16/5/23.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoldSectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView  *redDotView;

- (void) doSetContentData:(id) content;

- (id) updateTextColor:(UIColor *)textColor;

- (id) updateBackgroundColor: (UIColor *)backgroundColor;

- (id) updateTransform:(CGAffineTransform ) transform;

@end
