//
//  XHDDOnlineNotReadMessageCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineLastestMessageModel.h"

@interface XHDDOnlineNotReadMessageCell : UITableViewCell

//最近一条消息模型
@property (nonatomic, strong) XHDDOnlineLastestMessageModel *latestModel;

+ (instancetype)notReadMessageCellWithTableView:(UITableView *)tableView;

@end
