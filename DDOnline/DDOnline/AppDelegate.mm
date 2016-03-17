//
//  AppDelegate.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//
/*| JPUSH | I - [JPUSHSessionController] sis is not on protect
 2016-03-16 09:23:27.570 | JPUSH | I - [JPUSHAddressController] Action - sendSisRequest
 */

#import "AppDelegate.h"

#import "RESideMenu.h"
#import "XHDDOnlineMainController.h"
#import "XHDDOnlineSliderController.h"

#import "iflyMSC/IFlyMSC.h"
#import "JPUSHService.h"

#import "EMSDKFull.h"

@interface AppDelegate ()<EMClientDelegate/*回调*/>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //1.语音识别设置
    [self speechRecognizeServiceInit];
    
    //2.添加极光推送
    [self configJPushService:launchOptions];
  
    //3.环信通信
    [self configEMob:launchOptions];//appKey
    [self registEMAccount];//注册
    [self signInEM];//登录
    
    //4.设置根视图控制器
    [self setRootViewController];
    
    return YES;
}
//1.设置根视图控制器
- (void)setRootViewController{

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:[[XHDDOnlineMainController alloc] init] leftMenuViewController:[[XHDDOnlineSliderController alloc] init] rightMenuViewController:nil];
    
    self.window.rootViewController = sideMenu;
    [self.window makeKeyAndVisible];

}
//2.语音识别设置
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
//    NSString *notiType = userInfo[@"noti_type"];

    
    //3.获取通知内容
    NSString *message = apsInfo[@"alert"];
    
//    if ([notiType isEqualToString:@"alert"]) {
    
        // 这个枚举类型代表当前应用所处的状态，是在激活状态（前台），还是后台。
        //		UIApplicationStateActive,
        //		UIApplicationStateInactive,
        //		UIApplicationStateBackground
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
           
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
        }
//    }
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
#pragma mark - 环信相关
//4.0.1//配置
- (void)configEMob:(NSDictionary *)launchOptions{

    //1.注册appKey
    //AppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:EM_AppKey];
    options.apnsCertName = EM_ApnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
}
//4.0.2//注册环信
- (void)registEMAccount{
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:@"xianghongjiang" password:@"123456"];
    if (error==nil) {
        NSLog(@"注册成功");
    }else{
    
        JLog(@"%@",error.errorDescription);
    }

}
//4.0.3登录环信
- (void)signInEM{
    
    //需要登录时判断是否自动登录
//    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
//    if (isAutoLogin) {//如果自动登录直接返回
//        return;
//    }
    //否则登录
    EMError *error = [[EMClient sharedClient] loginWithUsername:@"xianghongjiang" password:@"123456"];
    if (!error) {//成功设置下次自动登录
        JLog(@"登陆成功");
        //设置下次自动登录
//        [[EMClient sharedClient].options setIsAutoLogin:YES];
        //设置自动登录代理
//        [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    }
}
//自动登录结果回调
- (void)didAutoLoginWithError:(EMError *)aError{
    JLog(@"%@",aError);
    
}
//掉线重连
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState{
    /*
     *  SDK连接服务器的状态变化时会接收到该回调
     *
     *  有以下几种情况, 会引起该方法的调用:
     *  1. 登录成功后, 手机无法上网时, 会调用该回调
     *  2. 登录成功后, 网络状态变化时, 会调用该回调
     *
     *  @param aConnectionState 当前状态
     */
    if (aConnectionState == EMConnectionConnected) {//已连接
        JLog(@"已连接");
        return;
    }
    if (aConnectionState == EMConnectionDisconnected)//未连接
    {
        JLog(@"未连接");
        
        //连接
    
    }
    
}
//退出登录
- (void)signOutEM{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
    }
}
//被动退出（被挤下线）
- (void)didLoginFromOtherDevice{
    
    JLog(@"被挤下线");
}
- (void)didRemovedFromServer{
    JLog(@"当前登录账号已经被从服务器端删除时会收到该回调");
}
#pragma mark - other
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //进入后台，让上标为0;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //4.0.2
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //进入前台，让上标为0;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //退出登录
    [self signOutEM];
}

@end
