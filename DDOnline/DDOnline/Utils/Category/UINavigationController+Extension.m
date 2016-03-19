//
//  UINavigationController+Extension.m
//  SinaWeiBo-Foundation
//
//  Created by qianfeng on 16/1/27.
//  Copyright (c) 2016年 JXH. All rights reserved.
//

#import "UINavigationController+Extension.h"
#import "NSObject+Extension.h"
#import "XHDDOnlineSignInController.h"

@implementation UINavigationController (Extension)
+(void)load{
    
    //    交换方法指向
    [UINavigationController exchangeOldMethod:@selector(pushViewController:animated:) withNewMethod:@selector(aop_pushViewController:animated:)];
    
}

-(void)aop_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
        //增加在push前的逻辑判断
    
       //判断是否是聊天界面
    if ([viewController isKindOfClass:NSClassFromString(@"XHDDOnlineChatController")]) {
                
        //1.判断是否登录
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//
        BOOL isAutoLogin = [[ud objectForKey:@"isAutoLogin"] boolValue];
        BOOL isLogin = [[ud objectForKey:@"isLogin"] boolValue];
        if ((!isAutoLogin) && (!isLogin)) {//不是自动登录 且未登录
            
            //跳转到登录页面
            XHDDOnlineSignInController *loginCtrl = [[XHDDOnlineSignInController alloc] init];
        
            [self aop_pushViewController:viewController animated:NO];
            [self aop_pushViewController:loginCtrl animated:YES];
            
            return;
        }
    }
    
    //3.执行原push方法
    [self aop_pushViewController:viewController animated:animated];
    
}
@end
