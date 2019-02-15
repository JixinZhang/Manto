//
//  TTLayoutGroupPicCell.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTLayoutGroupPicCell.h"
#import "TTNewsListResponse.h"

@interface TTLayoutGroupPicCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *TTArticlePicView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation TTLayoutGroupPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (id)createWithXib {
    NSString *class = NSStringFromClass([self class]);
    NSBundle *TTNewsBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"TTNewsBundle.bundle"]];
    return [TTNewsBundle loadNibNamed:class owner:nil options:nil].firstObject;
}

-  (void)setContentWithModel:(TTNewsInfoModel *)model {
    self.titleLabel.text = model.title;
    self.infoLabel.text = [NSString stringWithFormat:@"%@   %ld阅读",model.media_name, (long)model.read_count];
    
    TTNewsImageModel *leftModel = [model.image_list objectAtIndex:0];
    if (model.image_list.count == 3) {
        TTNewsImageModel *middleModel = [model.image_list objectAtIndex:1];
        TTNewsImageModel *rightModel = [model.image_list objectAtIndex:2];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.url]];
        [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:middleModel.url]];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.url]];
    } else {
        self.leftImageView.image = self.middleImageView.image = self.rightImageView.image = nil;
    }
}

@end
