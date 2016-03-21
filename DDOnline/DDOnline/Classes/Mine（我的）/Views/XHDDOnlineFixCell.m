//
//  XHDDOnlineFixCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFixCell.h"
#import "EMSDKFull.h"

@interface XHDDOnlineFixCell()



@end

@implementation XHDDOnlineFixCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)switchClicked:(UISwitch *)sender {//设置下次是否自动登录
    
    if ([self.nameLabel.text isEqualToString:@"自动登录"]) {
        
        [[EMClient sharedClient].options setIsAutoLogin:sender.isOn];
        
        [[NSUserDefaults standardUserDefaults] setObject:@(sender.isOn) forKey:@"isAutoLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
