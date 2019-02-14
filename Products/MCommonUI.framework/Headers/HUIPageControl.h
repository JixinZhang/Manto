//
//  HUIPageControl.h
//  MNewsFramework
//
//  Created by hushaohua on 10/16/16.
//  Copyright © 2016 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUIPageControl : UIPageControl

//horizontal left,right available
//contentHorizontalAlignment available
@property(nonatomic) UIEdgeInsets contentInsets;

@property(nonatomic) BOOL circleDot;//default YES;
@property(nonatomic) CGFloat dotCornerRadius;
@property (nonatomic,assign)CGSize dotSize;
@property (nonatomic,assign)CGSize currentDotSize;

@end
