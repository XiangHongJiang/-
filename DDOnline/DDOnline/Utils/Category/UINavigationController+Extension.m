//
//  UINavigationController+Extension.m
//  SinaWeiBo-Foundation
//
//  Created by qianfeng on 16/1/27.
//  Copyright (c) 2016年 JXH. All rights reserved.
//

#import "UINavigationController+Extension.h"
#import "NSObject+Extension.h"

@implementation UINavigationController (Extension)
+(void)load{
    
    //    交换方法指向
    [UINavigationController exchangeOldMethod:@selector(pushViewController:animated:) withNewMethod:@selector(aop_pushViewController:animated:)];
    
}

-(void)aop_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {//增加在push前的逻辑判断
        
        //1.判断是否登录
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        
//        BOOL login = [[ud objectForKey:@"isLogin"] boolValue];
//        
//        if (login == NO) {
//            
//            XHLoginViewController *loginVC = [[XHLoginViewController alloc] init];
//            
//            [self aop_pushViewController:loginVC animated:NO];
            
//            return;
//        }
        //2.未登录则弹出登录界面
        
    }
    
    //3.执行原push方法
    [self aop_pushViewController:viewController animated:animated];
    
}
@end
