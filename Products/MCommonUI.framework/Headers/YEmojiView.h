//
//  YEmojiView.h
//  MCommonUI
//
//  Created by 朱义 on 2018/12/11.
//  Copyright © 2018 WSCN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YEmojiView;

@protocol YEmojiViewDelegate <NSObject>

- (void)emojiView:(YEmojiView *)emojiView selectedEmoji:(NSString *)emoji;

- (void)emojiViewDidDeleted;

@end


@interface YEmojiView : UIView

@property (nonatomic, weak) id<YEmojiViewDelegate> delegate;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *deleteColor;

@end

NS_ASSUME_NONNULL_END
