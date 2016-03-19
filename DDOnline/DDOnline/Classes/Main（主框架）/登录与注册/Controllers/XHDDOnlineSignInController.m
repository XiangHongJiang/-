//
//  XHDDOnlineSignInController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/19.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineSignInController.h"
#import "XHDDOnlineRegistController.h"
#import "EMSDKFull.h"
#import "UIImage+Color.h"

@interface XHDDOnlineSignInController ()<EMClientDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordBtn;
@end

@implementation XHDDOnlineSignInController

//- (void)loadView{//重写这个方法则无法加载XIB
//    [super loadView];
//
//}
//配置子视图
- (void)configSubViews{
    
    //自动登录
    [self.autoLoginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.autoLoginBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    
    //登录
    self.loginBtn.layer.cornerRadius = 4;
    self.loginBtn.layer.masksToBounds = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //配置子视图
    [self configSubViews];
}
- (IBAction)registBtn:(UIButton *)sender {//注册
    
    XHDDOnlineRegistController *registCtrl = [[XHDDOnlineRegistController alloc] init];
    [self.navigationController pushViewController:registCtrl animated:YES];
}

- (IBAction)autoLoginBtn:(UIButton *)sender {//自动登录
    sender.selected = !sender.selected;
}
- (IBAction)loginBtn:(UIButton *)sender {//登录
    //登录
    [self signInEM];
}

- (IBAction)forgotPasswordBtn:(UIButton *)sender {//忘记密码
}

#pragma mark - 登录界面响应
//登录环信
- (void)signInEM{
    
    [SVProgressHUD showWithStatus:@"登录中..."];

    dispatch_async(JGlobalQueue, ^{
        
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.userNameTF.text password:self.passwordTF.text];
        dispatch_async(dispatch_get_main_queue(), ^{//登录成功与否的处理都需要回主线程
 
        if (!error) {//成功设置下次自动登录
            
                //设置下次是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:self.autoLoginBtn.selected];                
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//
            [ud setObject:@(self.autoLoginBtn.selected) forKey:@"isAutoLogin"];
            [ud setObject:@(YES) forKey:@"isLogin"];
            [ud synchronize];
            
            //发送登录状态
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isLogin" object:nil];

            [self.navigationController popViewControllerAnimated:YES];
                
        }
        else{//登录失败
            
            [SVProgressHUD showErrorWithStatus:error.errorDescription];
        }
            
    });
   
});
    
}
#pragma mark - 视图启动与消失代理设置
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[EMClient sharedClient] removeDelegate:self];
}


@end
