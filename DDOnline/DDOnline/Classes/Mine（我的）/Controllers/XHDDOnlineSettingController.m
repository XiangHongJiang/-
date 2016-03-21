//
//  XHDDOnlineSettingController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineSettingController.h"

@interface XHDDOnlineSettingController ()
/**
 *  <#Description#>
 */
@property (nonatomic, copy) NSArray *nameArray;
@end

@implementation XHDDOnlineSettingController

- (NSArray *)nameArray{

    if (_nameArray == nil) {
        
        self.nameArray = @[@"自动登录",@"退出登录",@"切换账号",@"清理缓存"];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineFixCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineFixCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return  self.nameArray.count;//自动登录,退出登录,切换账号,
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;

    
    
    return cell;
}

@end
