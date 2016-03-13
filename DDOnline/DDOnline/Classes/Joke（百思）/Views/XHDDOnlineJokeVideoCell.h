//
//  XHDDOnlineJokeVideoCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineJokeVideoModel.h"

@interface XHDDOnlineJokeVideoCell : UITableViewCell
/**
 *  JokeVideo_List
 */
@property (nonatomic, strong) JokeVideo_List *videoDetailModel;

+(id)jokeVideoCellWithTableView:(UITableView *)tableView;
//获取高度
+(CGFloat)rowHeightWithvideoDetailModel:(JokeVideo_List *)videoDetailModel;
@end
