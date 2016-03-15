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
@end

@implementation XHDDOnlineChatController

- (void)loadView{

    [super loadView];
    
    //添加scrollView
    [self addScrollView];
    
    //添加导航切换
    [self loadNavTitileView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    //    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
}
#pragma mark - 建立子视图
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

@end
