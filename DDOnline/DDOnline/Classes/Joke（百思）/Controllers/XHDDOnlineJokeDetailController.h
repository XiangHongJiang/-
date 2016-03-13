//
//  XHDDOnlineJokeDetailController.h
//  DDOnline
//
//  Created by qianfeng on 16/3/13.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHDDOnlineJokeBaseModel.h"
#import "XHDDOnlineJokeCell.h"

@interface XHDDOnlineJokeDetailController : UITableViewController
/** *  jokeBaseModel */
@property (nonatomic, strong) JokeBase_List *jokeBaseDetailModel;
/** *  jokeType */
@property (nonatomic, assign) JokeType jokeType;
@end
