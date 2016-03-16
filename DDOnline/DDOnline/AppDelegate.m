//
//  AppDelegate.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "AppDelegate.h"

#import "RESideMenu.h"
#import "XHDDOnlineMainController.h"
#import "XHDDOnlineSliderController.h"

#import "iflyMSC/IFlyMSC.h"
#import "JPUSHService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //1.设置根视图控制器
    [self setRootViewController];

     //2.语音识别设置
    [self speechRecognizeServiceInit];
    
    //3.添加极光推送
    [self configJPushService:launchOptions];
  

    
    return YES;
}
//1
- (void)setRootViewController{

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:[[XHDDOnlineMainController alloc] init] leftMenuViewController:[[XHDDOnlineSliderController alloc] init] rightMenuViewController:nil];
    
    self.window.rootViewController = sideMenu;

}
//2
- (void)speechRecognizeServiceInit{
    
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_NONE];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
}
#pragma mark - 极光推送相关

- (void)setJPushAlias{

//    [JPUSHService setTags:@"1520" alias:@"150114" callbackSelector:<#(SEL)#> object:<#(id)#>]
    
    [JPUSHService setTags:nil alias:@"150114" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
        // iResCode 为0 表示设置成功，6002 表示超时
        // 当设置别名失败的时候，重新调用此方法，继续设置，直到设置成功。
        
        if (iResCode != 0) {
            
            [self setJPushAlias];
        }
        else if(iResCode == 6002){
        
            JLog(@"设置别名请求超时");
            
        }
        else{
        
            JLog(@"请求成功");
        }
    }];
    
}
//3.0.0
- (void)configJPushService:(NSDictionary *)launchOptions{

    //启动Jpush
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey channel:JPushChannel apsForProduction:NO];
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    } else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
//
    // 申请远程推送权限
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];

}
//3.0.1
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    //接收到设备信息，可用来给相应设备发送推送消息
    [JPUSHService registerDeviceToken:deviceToken];
    
    [self setJPushAlias];
//    [JPUSHService setAlias:@"123" callbackSelector:@se object:<#(id)#>]
}
//3.0.2
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    //申请远程推送权限失败调用
    JLog(@"%@",error);
}
//3.0.3
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    //接收到推送消息后的处理在此进行 //ios7之后
    
    
    // 都需要先把推送消息用 极光推送处理。
    [JPUSHService handleRemoteNotification:userInfo];
    // 清空通知栏通知，清除应用 icon 上面的角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //处理推送消息
    //1.获取推送消息
    JLog(@"%@",userInfo);
    NSDictionary *apsInfo = userInfo[@"aps"];
    //2.取出通知类型
    NSString *notiType = userInfo[@"noti_type"];
    
    //3.获取通知内容
    NSString *message = apsInfo[@"alert"];
    
    if ([notiType isEqualToString:@"alert"]) {
        
        // 这个枚举类型代表当前应用所处的状态，是在激活状态（前台），还是后台。
        //		UIApplicationStateActive,
        //		UIApplicationStateInactive,
        //		UIApplicationStateBackground
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
        }
    }
    // 当应用点击通知栏进入的时候，跳转到相应的 viewController;
    // 根据应用不同的状态和通知的不同类型，做不同的处理。
    else{
        
        JLog(@"处理推送");
    
    
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}
//3.0.4接收本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
      [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];

}

#pragma mark - other

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //进入后台，让上标为0;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
