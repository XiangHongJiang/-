//
//  XHDDOnlineMineSkinCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineMineSkinCell.h"

@interface XHDDOnlineMineSkinCell()

@property (weak, nonatomic) IBOutlet UILabel *teamName;


@property (weak, nonatomic) IBOutlet UIImageView *teamBGView;


@end

@implementation XHDDOnlineMineSkinCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setSkinModel:(XHDDOnlineMineSkinModel *)skinModel{
    _skinModel = skinModel;
   
    //设置背景图片00
    NSString *picName = [NSString stringWithFormat:@"%@/setting_teams_bg.jpg",skinModel.address];
    self.teamBGView.image = [UIImage imageNamed:picName];
    
    self.teamName.text = skinModel.name;
    
    //获取沙盒当前皮肤设置选中
    NSString *theme = [[NSUserDefaults standardUserDefaults]objectForKey:@"skinAddress"];
    if ([skinModel.address isEqualToString:theme]) {
        self.leftBtn.selected = YES;
    }
    else{
        self.leftBtn.selected = NO;
    }
    
}

@end
