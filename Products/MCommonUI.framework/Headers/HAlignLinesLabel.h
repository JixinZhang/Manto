//
//  HLinesLabel.h
//  MCommonUI
//
//  Created by hushaohua on 2017/5/9.
//  Copyright © 2017年 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HVerticalAlignment){
    HVerticalAlignmentTop,
    HVerticalAlignmentCenter,
    HVerticalAlignmentBottom
};

@interface HAlignLinesLabel : UILabel

@property(nonatomic) HVerticalAlignment verticalAlignment;

@end
