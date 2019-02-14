//
//  ANLoadingButton.h
//  tinker
//
//  Created by hushaohua on 15/5/21.
//  Copyright (c) 2015年 wallstreetcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLoadingButton : UIButton

@property(nonatomic) UIActivityIndicatorViewStyle indicatorViewStyle; //enable for next loading

@property(nonatomic, strong) UIColor* loadingColor;

@property(nonatomic) BOOL loading;

@end
