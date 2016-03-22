//
//  XHDDOnlineJokePureTextCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokePureTextCell.h"

@interface XHDDOnlineJokePureTextCell()
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;//commend
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *profile_addv_authen;

@end

@implementation XHDDOnlineJokePureTextCell
#pragma mark - 注册复用
+ (id)jokePureTextCellWithTableView:(UITableView *)tableView{
    //类方法创建
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}
#pragma mark - 从Xib唤醒
- (void)awakeFromNib {
    
    self.headerImageView.layer.cornerRadius = 15;
    self.headerImageView.layer.masksToBounds = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark - 赋值数据，布局
- (void)setPureTextDetailModel:(JokeBase_List *)pureTextDetailModel{

    _pureTextDetailModel = pureTextDetailModel;

    NSString *headerUrlStr = pureTextDetailModel.u.header[0];
    
    self.profile_addv_authen.hidden = !pureTextDetailModel.u.is_vip;
    
    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:headerUrlStr]];
    //用户名
    self.nameLabel.text = pureTextDetailModel.u.name;
    //时间
    self.timeLabel.text = pureTextDetailModel.passtime;
    //内容
    self.contentLabel.text = pureTextDetailModel.text;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingBtn count:[pureTextDetailModel.up integerValue] placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:pureTextDetailModel.down placeholder:@"踩"];
    [self setupButtonTitle:self.shareBtn count:[pureTextDetailModel.bookmark integerValue] placeholder:@"分享"];
    [self setupButtonTitle:self.pinglunBtn count:[pureTextDetailModel.comment integerValue] placeholder:@"评论"];

}
#pragma mark - 类方法返回高度
//返回高度
+(CGFloat)rowHeightWithPureTextDetailModel:(JokeBase_List *)pureTextDetailModel{

    //110其他子视图的位置
    return pureTextDetailModel.textHeight + 110;
}
- (IBAction)duanziDingBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
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



@end
