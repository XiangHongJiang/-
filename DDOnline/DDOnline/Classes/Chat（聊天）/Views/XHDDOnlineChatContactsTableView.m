//
//  XHDDOnlineChatContactsTableView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/15.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatContactsTableView.h"

@interface XHDDOnlineChatContactsTableView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation XHDDOnlineChatContactsTableView

+ (instancetype)chatContactsTableView{
    
    XHDDOnlineChatContactsTableView *contactsTableView = [[XHDDOnlineChatContactsTableView alloc] initWithFrame:CGRectMake(JScreenWidth, 0, JScreenWidth, JScreenHeight - JTopSpace - JTabBarHeight) style:UITableViewStylePlain];
    
    contactsTableView.delegate = contactsTableView;
    contactsTableView.dataSource = contactsTableView;
    
    return contactsTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell  *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = @"123";
    
    return cell;
}

@end
