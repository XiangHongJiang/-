//
//  XHDDOnlineChatMessageTableView.h
//  DDOnline
//
//  Created by qianfeng on 16/3/15.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHDDOnlineChatMessageTableView : UITableView
/**
 *  消息数组
 */
@property (nonatomic, copy) NSArray *messageArray;

+ (instancetype)chatMessageTableView;

@end
