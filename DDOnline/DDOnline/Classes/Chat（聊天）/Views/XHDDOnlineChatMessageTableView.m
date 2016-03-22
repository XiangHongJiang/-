//
//  XHDDOnlineChatMessageTableView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/15.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatMessageTableView.h"
#import "XHDDOnlineNotReadMessageCell.h"
#import "XHDDOnlineLastestMessageModel.h"
#import "Entity.h"

@interface XHDDOnlineChatMessageTableView()<UITableViewDelegate,UITableViewDataSource>
/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *messageDataArray;

@end

@implementation XHDDOnlineChatMessageTableView

- (NSMutableArray *)messageDataArray{

    if (_messageDataArray == nil) {
        
        self.messageDataArray = [NSMutableArray array];
    }
    
    return _messageDataArray;
}

+ (instancetype)chatMessageTableView{

    XHDDOnlineChatMessageTableView *chatMessageTableView = [[XHDDOnlineChatMessageTableView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, JScreenHeight - JTopSpace - JTabBarHeight) style:UITableViewStylePlain];
    
    chatMessageTableView.delegate = chatMessageTableView;
    chatMessageTableView.dataSource = chatMessageTableView;
    
    //注册cell
    [chatMessageTableView registerNib:[UINib nibWithNibName:@"XHDDOnlineNotReadMessageCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineNotReadMessageCell"];
    
    chatMessageTableView.tableFooterView = [[UIView alloc] init];
    
    return chatMessageTableView;
}

- (void)setMessageDict:(NSDictionary *)messageDict{

    _messageDict = messageDict;
    
    [self.messageDataArray removeAllObjects];
    
    for (NSString *key in messageDict.allKeys) {
        
        //根据键值对，创建模型
        Entity *model = messageDict[key];
        
        XHDDOnlineLastestMessageModel *latestModel = [[XHDDOnlineLastestMessageModel alloc] init];
        
        latestModel.name = model.name;
        latestModel.lastMessage = model.message;
        latestModel.fromOther = [model.type boolValue];
        latestModel.time = model.time;
        
        [self.messageDataArray addObject:latestModel];
    }
    
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.messageDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XHDDOnlineNotReadMessageCell  *cell = [XHDDOnlineNotReadMessageCell notReadMessageCellWithTableView:tableView];
    
    cell.latestModel = self.messageDataArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return @"消息列表";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UINavigationController *nav = [XHUtils getCurrentTabBarNavigationCtrl];
    nav.tabBarItem.badgeValue = nil;
    
}

@end
