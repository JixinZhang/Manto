//
//  GoldBaseReponse.h
//  GoldRPCFramework
//
//  Created by Micker on 16/5/12.
//  Copyright © 2016年 wallstreetcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoldBaseReponse : NSObject<NSCoding>

@property(nonatomic, strong) id rawContent;

- (id) initWithContent:(id) content;

- (void) appendContent:(id) content;

- (id) initWithContent:(id) content retainRawContent:(BOOL)retainRawContent;

@end



#pragma mark --
#pragma mark -- GoldErrorResponse

/*!
 *	应ZY的需求，将本不属于此库的类写在这里，仅作wscn的错误处理类！
 *  
 *  代码使用举例如下：
 *  [[GoldErrorResponse alloc] initWithContent:[request.error.userInfo objectForKey:AFNetworkingTaskDidCompleteErrorResponseKey]]
 */
@interface GoldErrorResponse : GoldBaseReponse

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *message_human;

@end
