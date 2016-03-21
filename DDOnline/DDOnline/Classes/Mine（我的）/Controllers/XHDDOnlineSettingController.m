//
//  XHDDOnlineSettingController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineSettingController.h"
#import "XHDDOnlineFixCell.h"
#import "SDImageCache.h"
#import "EMSDKFull.h"
#import "XHDDOnlineSignInController.h"

@interface XHDDOnlineSettingController ()
/**
 *  <#Description#>
 */
@property (nonatomic, copy) NSArray *nameArray;
@end

@implementation XHDDOnlineSettingController

- (NSArray *)nameArray{

    if (_nameArray == nil) {
        
        self.nameArray = @[@"自动登录",@"清理缓存",@"切换账号",@"退出登录"];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineFixCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineFixCell"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];                               
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
    
    XHDDOnlineFixCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineFixCell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {//@[@"自动登录",@"切换账号",@"清理缓存",@"退出登录"];
         cell.functionSwitch.hidden = NO;
        cell.functionSwitch.on = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isAutoLogin"] boolValue];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.section == 1) {
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@(%.2fM)",self.nameArray[indexPath.section],[SDImageCache sharedImageCache].getSize / 1024 / 1024.0];//self.nameArray[indexPath.section];
        return cell;
    }
    cell.nameLabel.text = self.nameArray[indexPath.section];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger section = indexPath.section;
    
    if (section == 1) {
        
        [[SDImageCache sharedImageCache] cleanDisk];
        XHDDOnlineFixCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [SVProgressHUD showSuccessWithStatus:@"清理缓存成功"];
        cell.nameLabel.text = @"清理缓存(0.00M)";
        
    }
    else if (section == 2){
        
        XHDDOnlineSignInController *signCtrl = [[XHDDOnlineSignInController alloc] init];
        [self.navigationController pushViewController:signCtrl animated:YES];

    }
    else if (section == 3){
    
        if ([EMClient sharedClient].currentUsername.length == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"当前未登录"];
        }
        else{
            
            [self signOutUser];
        }
        
    }
    
    
}
- (void)signOutUser{

    dispatch_async(JGlobalQueue, ^{
        
        //退出原账号
        if ([EMClient sharedClient].currentUsername.length >0) {
            EMError *error1 = [[EMClient sharedClient] logout:YES];
            if (error1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:error1.errorDescription];
                });
 
            }
        }
    });
  
}
                   
@end
