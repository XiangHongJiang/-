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

@interface XHDDOnlineChatController ()<UIScrollViewDelegate>
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
@property (nonatomic, strong) NSMutableArray *messageDataArray;
@end

@implementation XHDDOnlineChatController

- (NSMutableArray *)contactsDataArray{

    if (_contactsDataArray == nil) {
        
        _contactsDataArray = [NSMutableArray new];
    }
    
    return _contactsDataArray;
}

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
    //    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    //    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    //请求数据
    [self requestContactsDataArray];
    
    //添加下拉刷新
    [self addRefresh];
    
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
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarBtnAction)];
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
    contentScrollView.backgroundColor = [UIColor orangeColor];
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
        //                  self.contactsTableView.enterEditting = YES;
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
            JLog(@"获取联系人失败");
        }
        
        //获取黑名单列表
        EMError *error1 = nil;
        NSArray *blackList = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error1];
        if (!error1) {
            NSLog(@"获取黑名单成功 -- %@",blackList);
        }
        else{
            JLog(@"获取黑名单失败");
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
@end
