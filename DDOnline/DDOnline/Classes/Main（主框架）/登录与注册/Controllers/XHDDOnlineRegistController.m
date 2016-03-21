//
//  XHDDOnlineRegistController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/19.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineRegistController.h"
#import "EMSDKFull.h"
#import "UIView+Border.h"
#import "ReactiveCocoa.h"
#import "UIImage+Color.h"

@interface XHDDOnlineRegistController ()
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic)IBOutlet UITextField *phoneNumberTF;

@property (weak, nonatomic) IBOutlet UITextField *checkCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *checkCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@end

@implementation XHDDOnlineRegistController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"新用户注册";
    
    [self configSubViews];
    
    //1.添加监听
    [self setupRAC];
    
}
- (void)configSubViews{
    
    self.registBtn.layer.cornerRadius = 4;
    self.registBtn.layer.masksToBounds = YES;
    
    [self.registBtn setBackgroundImage:[UIImage imageWithColor:JColorFontDetail] forState:UIControlStateDisabled];
    [self.registBtn setBackgroundImage:[UIImage imageWithColor:JColorMain] forState:UIControlStateNormal];
    [self.registBtn setBackgroundImage:[UIImage imageWithColor:JColorDarkGray] forState:UIControlStateHighlighted];

    
    [self.phoneNumberTF drawLineWithColor:[UIColor grayColor] locate:WLocateTop andPedding:0];
    [self.phoneNumberTF drawLineWithColor:[UIColor grayColor] locate:WLocateBottom andPedding:0];
    
    [self.passwordTF drawLineWithColor:[UIColor grayColor] locate:WLocateTop andPedding:0];
    [self.passwordTF drawLineWithColor:[UIColor grayColor] locate:WLocateBottom andPedding:0];
    
    [self.checkCodeTF drawLineWithColor:[UIColor grayColor] locate:WLocateRight andPedding:0];
    [self.inviteCodeTF drawLineWithColor:[UIColor grayColor] locate:WLocateBottom andPedding:0];
    
    UIButton *seePassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seePassBtn setImage:[UIImage imageNamed:@"Password_show"] forState:UIControlStateNormal];
    [seePassBtn setImage:[UIImage imageNamed:@"Password_hide"] forState:UIControlStateSelected];
    self.passwordTF.rightView = seePassBtn;
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    [seePassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    [seePassBtn addTarget:self action:@selector(seePassword:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)seePassword:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.passwordTF.secureTextEntry = !btn.isSelected;
}
- (void)setupRAC{
    
    RAC(self.registBtn,enabled) = [RACSignal combineLatest:@[self.phoneNumberTF.rac_textSignal, self.passwordTF.rac_textSignal, self.checkCodeTF.rac_textSignal] reduce:^id(NSString *phoneNumber, NSString *password, NSString *checkCode){
        
        return @(phoneNumber.length >=3 && password.length >= 6);
        
    }];
    
    RAC(self.checkCodeBtn,enabled) = [RACSignal combineLatest:@[self.phoneNumberTF.rac_textSignal] reduce:^id(NSString *phoneNumber){
        
        return @(phoneNumber.length == 11);
        
    }];
    
}
#pragma mark - response
- (IBAction)getCheckCode:(UIButton *)sender {
    
    //1.发送请求
    
    //2.进入倒计时（不可用）
    
}
- (IBAction)registAction:(UIButton *)sender {
    //注册环信
    [self registEMAccount];
    
}
//注册环信
- (void)registEMAccount{
    
    [SVProgressHUD showWithStatus:@"注册中..."];
    
    dispatch_async(JGlobalQueue, ^{
        
        EMError *error = [[EMClient sharedClient] registerWithUsername:self.phoneNumberTF.text password:self.passwordTF.text];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error==nil) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                
            }else{
                [SVProgressHUD showErrorWithStatus:error.errorDescription];
            }
        });
    });
}


@end
