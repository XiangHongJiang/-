//
//  XHDDOnlineJokeVideoCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineJokeBaseModel.h"
#import "CLVideoPlayerView.h"

@interface XHDDOnlineJokeVideoCell : UITableViewCell
/**
 *  playView
 */
@property (nonatomic, weak) CLVideoPlayerView *playView;
/** *  JokeVideo_List */
@property (nonatomic, strong) JokeBase_List *videoDetailModel;
@property (weak, nonatomic) IBOutlet UIButton *playVideoBtn;

+(id)jokeVideoCellWithTableView:(UITableView *)tableView;
//获取高度
+(CGFloat)rowHeightWithvideoDetailModel:(JokeBase_List *)videoDetailModel;
@end
