//
//  XHDDOnlineFixCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHDDOnlineFixCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *preImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *functionSwitch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *preImageRightAutoLayout;


@end
