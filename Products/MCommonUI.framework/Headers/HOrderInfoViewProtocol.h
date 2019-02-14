//
//  HOrderInfoViewProtocol.h
//  MCommonUI
//
//  Created by hushaohua on 2/14/17.
//  Copyright © 2017 WSCN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HOrderInfoViewDelegate <NSObject>

- (void) orderInfoViewDidInteractive;

@end

@protocol HOrderInfoViewProtocol <NSObject>

@optional
- (void) setOrderContentData:(id)contentData;
@property(nonatomic, weak) id<HOrderInfoViewDelegate> orderViewDelegate;
- (id) currentOrderContent;

@end
