//
//  XHDDOnlineChatMessageCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineChatMessageModel.h"

@interface XHDDOnlineChatMessageCell : UITableViewCell

@property (nonatomic, strong) XHDDOnlineChatMessageModel *message;
+ (id)messageCellWithTableView:(UITableView *)tableView;
@end
