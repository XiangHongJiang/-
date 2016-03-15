//
//  XHDDOnlineChatMessageTableView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/15.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatMessageTableView.h"

@interface XHDDOnlineChatMessageTableView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation XHDDOnlineChatMessageTableView

+ (instancetype)chatMessageTableView{

    XHDDOnlineChatMessageTableView *chatMessageTableView = [[XHDDOnlineChatMessageTableView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, JScreenHeight - JTopSpace - JTabBarHeight) style:UITableViewStylePlain];
    
    chatMessageTableView.delegate = chatMessageTableView;
    chatMessageTableView.dataSource = chatMessageTableView;
    
    return chatMessageTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell  *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = @"text";
    
    return cell;
}

@end
