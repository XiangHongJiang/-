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
        
        cell.nameLabel.text = self.nameArray[indexPath.section];//self.nameArray[indexPath.section];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"( %.2fM )",[SDImageCache sharedImageCache].getSize / 1024 / 1024.0];
        label.textColor = [UIColor colorWithRed:1.000 green:0.056 blue:0.000 alpha:0.800];
        cell.accessoryView = label;
        label.textAlignment = NSTextAlignmentRight;
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
        
        [[SDImageCache sharedImageCache] clearDisk];
        XHDDOnlineFixCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [SVProgressHUD showSuccessWithStatus:@"清理缓存成功"];
        
        cell.nameLabel.text = @"清理缓存(0.00M)";
        
        
//        cell.accessoryView = ;
        
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
            if (error1) {
                
                    [SVProgressHUD showErrorWithStatus:error1.errorDescription];
               
 
            }
            else{
            [SVProgressHUD showSuccessWithStatus:@"退出成功！"];
            }
                 });
        }
    });
  
}
                   
@end
