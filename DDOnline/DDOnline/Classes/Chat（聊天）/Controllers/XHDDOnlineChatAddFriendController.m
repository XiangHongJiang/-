//
//  XHDDOnlineChatAddFriendController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatAddFriendController.h"
#import "EMSDKFull.h"

@interface XHDDOnlineChatAddFriendController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextView *beizhuTextView;
- (IBAction)addFriendSureBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *addRequestTableView;

@end

@implementation XHDDOnlineChatAddFriendController

- (void)loadView{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加好友";
    self.automaticallyAdjustsScrollViewInsets = NO;

}
#pragma mark - tableView代理相关
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    return cell;
}

#pragma mark - 确认添加请求
- (IBAction)addFriendSureBtn:(UIButton *)sender {
    //请求添加好友
    
}
@end
