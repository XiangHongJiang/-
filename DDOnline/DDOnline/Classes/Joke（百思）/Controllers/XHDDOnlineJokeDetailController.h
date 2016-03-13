//
//  XHDDOnlineJokeDetailController.h
//  DDOnline
//
//  Created by qianfeng on 16/3/13.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHDDOnlineJokeGifModel.h"
#import "XHDDOnlineJokePureTextModel.h"
#import "XHDDOnlineJokeVideoModel.h"

@interface XHDDOnlineJokeDetailController : UITableViewController
/**
 *  pureTextDetailModel
 */
@property (nonatomic, strong) PureText_List *pureTextDetailModel;
/**
 *  XHDDOnlineJokeGifModel
 */
@property (nonatomic, strong) JokeGF_List *gifDetailModel;
/**
 *  JokeVideo_List
 */
@property (nonatomic, strong) JokeVideo_List *videoDetailModel;
@end
