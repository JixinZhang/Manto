//
//  TTLayoutRightPicCell.m
//  TTNews
//
//  Created by AlexZhang on 2019/2/14.
//  Copyright © 2019 AlexZhang. All rights reserved.
//

#import "TTLayoutRightPicCell.h"
#import "TTNewsListResponse.m"

@interface TTLayoutRightPicCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeight;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceLabelWidth;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoLabelX;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoLabelWidth;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeBtnTop;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeBtnTrail;

@end

@implementation TTLayoutRightPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.closeBtn setImage:[UIImage imageNamed:@"add_textpage_17x12_"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentWithModel:(TTNewsInfoModel *)model {
//    self.titleLabelHeight.constant = 75;
//    self.closeBtnTop.constant = 322;
//    self.closeBtnTrail.constant = -7;
    
    
    self.titleLabel.text = model.title;
    self.infoLabel.text = [NSString stringWithFormat:@"%ld阅读", (long)model.read_count];
    self.sourceLabel.text = model.media_name;
    
    TTNewsImageModel *leftModel = [model.image_list objectAtIndex:0];
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.url]];
}

@end
