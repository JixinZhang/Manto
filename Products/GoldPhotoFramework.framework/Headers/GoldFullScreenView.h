//
//  GoldFullScreenView.h
//  B5MFullScreenFramework
//
//  Created by Micker on 16/2/14.
//  Copyright © 2016年 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoldFullScreenView : UIView

@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, strong) UIImageView   *imageView;

@property (nonatomic, assign, setter=enableDoubleTap:) BOOL isDoubleTapEnabled;

@property (nonatomic, copy) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);

- (void) reloadData;

@end
