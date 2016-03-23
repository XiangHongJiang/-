//
//  XHDDOnlineJokeDetailCommentsCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeDetailCommentsCell.h"

@interface XHDDOnlineJokeDetailCommentsCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImaegView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

- (IBAction)zanBtnClick:(UIButton *)sender;

@end

@implementation XHDDOnlineJokeDetailCommentsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)zanBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [self setupButtonTitle:sender count:[sender.titleLabel.text integerValue] + 1 placeholder:@"顶"];
    }
    else{
        
        [self setupButtonTitle:sender count:[sender.titleLabel.text integerValue] - 1 placeholder:@"顶"];
    }
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
-(void)setCommentsModel:(Comments_Data *)commentsModel{
    _commentsModel = commentsModel;
   
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:commentsModel.user.profile_image] placeholderImage:nil];
    
    //设置头像的圆角
    self.headImageView.layer.cornerRadius = self.headImageView.width / 2;
    self.headImageView.layer.masksToBounds = YES;
    
    //设置性别的image
    if ([commentsModel.user.sex isEqualToString:@"m"]) {
        self.sexImaegView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexImaegView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    self.nameLabel.text = commentsModel.user.username;
    self.contentLabel.text = commentsModel.content;
    self.likeCountLabel.text = commentsModel.like_count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    if (section == 1) {
//        return 30;
//    }else{
//        
//        return 0;
//    }
//}

@end
