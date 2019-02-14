//
//  TTLayoutGroupPicCell.h
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTLayoutGroupPicCell : UITableViewCell

+ (id)createWithXib;

- (void)setContentWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
