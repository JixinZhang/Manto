//
//  SYAlert.h
//  dafan
//
//  Created by iMac on 14/11/13.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^HUIAlertAction)(void);

@interface HUIAlert : NSObject

//only UIAlertController
- (void) updateTitle:(NSString *)title;
- (void) updateMessage:(NSString *)message;

+ (HUIAlert *) showWithTitle:(NSString *)title;

- (id) initWithActionSheetTitle:(NSString *)title message:(NSString *)message;
- (id) initWithTitle:(NSString *)title message:(NSString *)message;

- (UITextField *) textFieldAtIndex:(NSInteger)index;
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

- (void) addTitle:(NSString *)title action:(HUIAlertAction)action;

- (void) show;
- (void) dismiss;
- (void) dismissCompletion:(void (^)(void))completion;

@end
