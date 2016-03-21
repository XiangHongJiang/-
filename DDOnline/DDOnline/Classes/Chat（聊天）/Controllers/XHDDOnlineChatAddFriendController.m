//
//  XHDDOnlineChatAddFriendController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatAddFriendController.h"
#import "EMSDKFull.h"

@interface XHDDOnlineChatAddFriendController ()<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextView *beizhuTextView;

@property (weak, nonatomic) IBOutlet UIButton *addFriendSureBtn;
@end

@implementation XHDDOnlineChatAddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加好友";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.beizhuTextView.layer.cornerRadius = 4;
    self.beizhuTextView.layer.masksToBounds = YES;
    
    self.addFriendSureBtn.layer.cornerRadius = 4;
    self.addFriendSureBtn.layer.masksToBounds= YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 确认添加请求
- (IBAction)addFriendSureBtn:(UIButton *)sender {
    
    //请求添加好友
    EMError *error = [[EMClient sharedClient].contactManager addContact:self.userNameTF.text message:self.beizhuTextView.text];
    if (!error) {
        NSLog(@"发送添加请求成功");        
        [SVProgressHUD showSuccessWithStatus:@"发送添加请求成功"];
    }
    self.userNameTF.text = @"";
    self.beizhuTextView.text = @"请输入备注信息...";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
}
@end
