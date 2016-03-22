//
//  XHDDOnlineChatController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatController.h"
#import "UIImage+Color.h"
#import "XHDDOnlineChatMessageTableView.h"
#import "XHDDOnlineChatContactsTableView.h"
#import "EMSDKFull.h"
#import "XHDDOnlineChatFunctionView.h"
#import "XHDDOnlineChatAddFriendController.h"
#import "XHDDOnlineChatMessageModel.h"

#import "Entity+CoreDataProperties.h"

@interface XHDDOnlineChatController ()<UIScrollViewDelegate,EMContactManagerDelegate,UIAlertViewDelegate,EMClientDelegate,EMChatManagerDelegate>
{
    BOOL firstTimeEnter;
    
}
/**
 *     CoreDada中管理数据的上下文，做增删改查需要使用到
 */
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

/** *  消息btn */
@property (nonatomic, weak) UIButton *leftBtn;
/** *  联系人btn */
@property (nonatomic, weak) UIButton * rightBtn;
/** *  contentScrollView */
@property (nonatomic, weak) UIScrollView * contentScrollView;
/** *  联系人tableView */
@property (nonatomic, weak) XHDDOnlineChatContactsTableView * contactsTableView;
/** *  消息tableView */
@property (nonatomic, weak) XHDDOnlineChatMessageTableView * messageTableView;
/** *  联系人数组 */
@property (nonatomic, strong) NSMutableArray *contactsDataArray;
/** *  消息数组 */
@property (nonatomic, strong) NSMutableDictionary *messageDataDict;
@end

@implementation XHDDOnlineChatController

- (NSManagedObjectContext *)managedObjectContext{

    if (_managedObjectContext == nil) {
       
        //1.获取路径;编译后类型会变成mode; 根据路径加载文件中所有的模型
        NSString *momdPath = [[NSBundle mainBundle] pathForResource:@"HistoryMessageModel" ofType:@"momd"];
        NSManagedObjectModel *managedModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:momdPath]];
        
        //2.创建持久化存储协调器（相当于数据库和文件的连接器）
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedModel];
        
        //3.指定数据库的存储路径
        NSString *savaPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/historyMessageInfo.sqlist"];
        
        //4.设置路径
        NSPersistentStore *sotre = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:savaPath] options:nil error:nil];
        //5.创建托管上下文
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        
        //6.关联协调器
        _managedObjectContext.persistentStoreCoordinator = coordinator;
        
    }
    
    return _managedObjectContext;
}

- (NSMutableDictionary *)messageDataDict{

    if (_messageDataDict == nil) {
        
        _messageDataDict = [NSMutableDictionary dictionary];
        
    }
    return _messageDataDict;
}

- (NSMutableArray *)contactsDataArray{

    if (_contactsDataArray == nil) {
        
        _contactsDataArray = [NSMutableArray new];
    }
    return _contactsDataArray;
}
/** 部署子视图*/
- (void)loadView{
    [super loadView];
    //添加scrollView
    [self addScrollView];
    //添加导航切换
    [self loadNavTitileView];
    //添加右btn
    [self addRightBarBtn];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加下拉刷新
    [self addRefresh];
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];        
    
    //监听好友回调
    [self addFriendDelegate];
    
    //添加通知监听
    [self setNotificationCentenr];
    
}
#pragma mark - 通知中心监听通知
- (void)setNotificationCentenr{
    //监听登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOrNot) name:@"loginSucceed" object:nil];
}
#pragma mark - 添加刷新
/** *  添加刷新 */
- (void)addRefresh{
    self.contactsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestContactsDataArray)];
}
#pragma mark - 建立子视图
//右btn
- (void)addRightBarBtn{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"right_menu_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnAction)];
}
//导航头
- (void)loadNavTitileView{

    UIView *NavTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    NavTitleView.layer.borderColor = [UIColor whiteColor].CGColor;
    NavTitleView.layer.borderWidth = 1;
    self.navigationItem.titleView = NavTitleView;
    NavTitleView.layer.cornerRadius = 5;
    NavTitleView.layer.masksToBounds = YES;


    UIButton *leftButton = [XHUtils creatBtnWithFrame:CGRectMake(0, 0, 59, 30) title:@"消息" target:self action:@selector(messageAction:)];
    self.leftBtn = leftButton;
    
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] forState:UIControlStateSelected];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    leftButton.selected = YES;
    [NavTitleView addSubview:leftButton];
    
    UIButton *rightButton = [XHUtils creatBtnWithFrame:CGRectMake(60, 0, 60, 30) title:@"联系人" target:self action:@selector(contactsAction:)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] forState:UIControlStateSelected];
    [rightButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavTitleView addSubview:rightButton];
    self.rightBtn = rightButton;
    
}
//添加scorllView
- (void)addScrollView{

    //scrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, JScreenWidth, JScreenHeight - JTopSpace - JTabBarHeight)];
    [self.view addSubview:contentScrollView];
    contentScrollView.backgroundColor = [UIColor whiteColor];
    contentScrollView.contentSize = CGSizeMake(JScreenWidth * 2, 0);
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.bounces = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    self.contentScrollView = contentScrollView;
    
    //messageTableView
    XHDDOnlineChatMessageTableView *messageTableView = [XHDDOnlineChatMessageTableView chatMessageTableView];
    [contentScrollView addSubview:messageTableView];
    self.messageTableView = messageTableView;
    
    //contactsTableView
    XHDDOnlineChatContactsTableView *contactsTableView = [XHDDOnlineChatContactsTableView chatContactsTableView];
    self.contactsTableView = contactsTableView;
    [contentScrollView addSubview:contactsTableView];

}
#pragma mark - 导航titleView点击事件
- (void)messageAction:(UIButton *)msgBtn{
    msgBtn.selected = YES;
    self.rightBtn.selected = NO;
    self.contentScrollView.contentOffset = CGPointMake(0, 0);

}
- (void)contactsAction:(UIButton *)contactsBtn{
    contactsBtn.selected = YES;
    self.leftBtn.selected = NO;
    self.contentScrollView.contentOffset = CGPointMake(JScreenWidth, 0);
}
#pragma mark - 右导航btn点击事件
- (void)rightBarBtnAction{

    JLog(@"点击了加号");
    
    XHDDOnlineChatFunctionView *chatFunctionView = [XHDDOnlineChatFunctionView chatFunctionView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:chatFunctionView];
    
    chatFunctionView.functionBlock = ^(ChatFunctionViewFunctionType functionType){
    
        switch (functionType) {
            case ChatFunctionViewFunctionTypeEditing://编辑状态
            {
                [self changeNavBtnState];
                
                JLog(@"进入编辑状态");
                //判断当前进入的是哪一页的编辑状态，（联系人还是消息）
                if (self.contentScrollView.contentOffset.x == JScreenWidth) {
                    self.contactsTableView.enterEditting = YES;
                }
                else{
//                  self.contactsTableView.enterEditting = YES;
                    JLog(@"消息进入编辑状态");
                }
                
            }
                break;
                
            case ChatFunctionViewFunctionTypeAddFriends:
            {
                [self.navigationController pushViewController:[[XHDDOnlineChatAddFriendController alloc] init] animated:NO];
                
                JLog(@"进入添加好友界面");
            }
                break;
                
            case ChatFunctionViewFunctionTypeScan:
            {
                JLog(@"进入扫一扫界面");
            }
                break;
            default:
                break;
        }
    };
    
}
//改变btn状态
- (void)changeNavBtnState{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
#pragma mark -  编辑确认
- (void)sureAction{
    //判断
    //判断当前进入的是哪一页的编辑状态，（联系人还是消息）
    if (self.contentScrollView.contentOffset.x == JScreenWidth) {
        self.contactsTableView.deleteAction = YES;
//        self.contactsTableView.enterEditting = NO;
    }
    else{
        JLog(@"消息进入编辑状态");
    }

    [self addRightBarBtn];

}
/**滚动换页*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //开始滚动，动态更新快速导航视图状态
    int  currentIndex = (scrollView.contentOffset.x + JScreenWidth * 0.5) / JScreenWidth;
    if (currentIndex == 1) {
        self.rightBtn.selected = YES;
        self.leftBtn.selected = NO;
    }
    else{
        self.rightBtn.selected = NO;
        self.leftBtn.selected = YES;
    }
    [self.view endEditing:YES];
}
#pragma mark - 请求数据
- (void)requestContactsDataArray{

    [self.contactsDataArray removeAllObjects];
    
    dispatch_async(JGlobalQueue, ^{
        
        //获取好友列表
        EMError *error = nil;
        NSArray *userList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            NSLog(@"获取好友成功 -- %@",userList);
        }
        else{
            JLog(@"获取联系人失败%@",error.errorDescription);
        }
        
        //获取黑名单列表
        EMError *error1 = nil;
        NSArray *blackList = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error1];
        if (!error1) {
            NSLog(@"获取黑名单成功 -- %@",blackList);
        }
        else{
            JLog(@"获取黑名单失败%@",error1.errorDescription);
        }
        
        if (userList != nil && blackList != nil) {
            //添加好友与黑名单列表
            [self.contactsDataArray addObject:userList];
            [self.contactsDataArray addObject:blackList];
        }
        
        //回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.contactsTableView.mj_header endRefreshing];

            //赋值联系人tableView
            self.contactsTableView.contactsArray = self.contactsDataArray;

        });
        
    });
    
}
#pragma mark - 监听好友申请信息
/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:aUsername message:[NSString stringWithFormat:@"申请添加你为好友:\n%@",aMessage] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"同意", @"拒绝",nil];
    
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:alertView.title];
        if (!error) {
            NSLog(@"同意添加");

            [self.contactsDataArray[0] removeObject:alertView.title];
            [self.contactsDataArray[0] addObject:alertView.title];
            
            self.contactsTableView.contactsArray = self.contactsDataArray;
            
        }
    }
    else
    {
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:alertView.title];
        if (!error) {
            NSLog(@"拒绝添加");
        }
        
    }
}
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername{

    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@ 同意了好友请求",aUsername]];
    
    [self.contactsDataArray[0] removeObject:aUsername];
    [self.contactsDataArray[0] addObject:aUsername];
    self.contactsTableView.contactsArray = self.contactsDataArray;
}
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername{

 [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@ 拒绝了好友请求",aUsername]];
}
#pragma mark - 消息界面相关
//1.获取会话列表

//2.监听在线消息
#pragma mark - 登录成功相关
//手动登录状态判断
- (void)isLoginOrNot{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//
    BOOL isLogin = [[ud objectForKey:@"isLogin"] boolValue];
    if (isLogin) {//如果已经登录，则请求数据
        
        [self.contactsTableView.mj_header beginRefreshing];

    }
}
- (void)addFriendDelegate{
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}
- (void)dealloc{//移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didAutoLoginWithError:(EMError *)aError{
    JLog(@"%@",aError);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//
    if (aError) {
        [SVProgressHUD showErrorWithStatus:aError.errorDescription];
        [ud setObject:@(NO) forKey:@"isLogin"];
    }
    else{
        [SVProgressHUD showSuccessWithStatus:@"自动登录成功"];
       
        //沙盒存登录状态
        [ud setObject:@(YES) forKey:@"isLogin"];
        [ud synchronize];

        //发送登录成功通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSucceed" object:nil];
        
        return;
    }
    
   [ud synchronize];
    
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
//被动退出（被挤下线）
- (void)didLoginFromOtherDevice{
    
    JLog(@"被挤下线");
}
- (void)didRemovedFromServer{
    JLog(@"当前登录账号已经被从服务器端删除时会收到该回调");
}
#pragma mark - 视图启动与消失代理设置
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];//
    BOOL isLogin = [[ud objectForKey:@"isLogin"] boolValue];
    if (!isLogin && !firstTimeEnter) {//未登录，并且是第一次进入该界面
        firstTimeEnter = YES;
        [SVProgressHUD showSuccessWithStatus:@"当前未登陆"];
    }
    
    if ([EMClient sharedClient].currentUsername.length > 0) {//当前有登录
        
        //从数据库获取数据
        [self getDataFromCoreDataDB];
    }
    
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
#pragma mark - 离线消息监听 - 解析消息回调
- (void)didReceiveMessages:(NSArray *)aMessages{//接收到哪个实体就保存哪个实体
    
    for (EMMessage *message in aMessages) {
        // cmd消息中的扩展属性
        NSDictionary *ext = message.ext;
        
        XHDDOnlineChatMessageModel *model = [XHDDOnlineChatMessageModel messageWithDict:ext];
        
        //创建一个实体
        Entity *messageEntity = (Entity *)[NSEntityDescription insertNewObjectForEntityForName:@"HistoryMessageEntity" inManagedObjectContext:self.managedObjectContext];
        
        //实体赋值
        messageEntity.name = [NSString stringWithFormat:@"%@/%@",[EMClient sharedClient].currentUsername,model.name];
        messageEntity.message = model.text;
        messageEntity.time = model.time;
        messageEntity.type = @(YES);
        
        //实体保存
        if ([_managedObjectContext save:nil]){
            NSLog(@"保存实体成功");
        }
        
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[self.navigationController.tabBarItem.badgeValue intValue] + 1];
        
        //更新消息界面最新显示
        [self.messageDataDict setObject:messageEntity forKey:messageEntity.name];
        self.messageTableView.messageDict = self.messageDataDict;
        
    }
}
- (void)getDataFromCoreDataDB{//执行一次查询，取出本地化数据,存储最新一条
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"HistoryMessageEntity"];
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
#warning 获取之前所有的聊天的对象//必须登录
    for (int i = 0; i < results.count; i ++) {
        Entity *entityModel = results[i];
        NSString *name = entityModel.name;
        
        [self.messageDataDict setObject:entityModel forKey:name];
        
    }
    //自动刷新了
    self.messageTableView.messageDict = self.messageDataDict;
    
}
@end
