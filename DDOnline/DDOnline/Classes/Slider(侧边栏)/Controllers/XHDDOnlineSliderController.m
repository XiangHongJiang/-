//
//  XHDDOnlineSliderController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineSliderController.h"
#import "RESideMenu.h"
#import "XHDDOnlineSignInController.h"
#import "XHDDOnlineRootTabBarController.h"
#import "EMSDKFull.h"
#import "XHDDOnlineMineSkinController.h"
#import "XHDDOnlineSettingController.h"

@interface XHDDOnlineSliderController ()<UITableViewDelegate, UITableViewDataSource>
/** *  cellImageNameArray */
@property (nonatomic, copy) NSArray *cellImageNameArray;
/** *  cellTitleArray */
@property (nonatomic, copy) NSArray *cellTitleArray;
/** *  userNameLabel */
@property (nonatomic, weak) UILabel *userNameLabel;
/** *  skinAddress */
@property (nonatomic, copy) NSString *skinAddress;
/**
 *  nightSwitch
 */
@property (nonatomic, weak) UISwitch * nightSwitch;
@end

@implementation XHDDOnlineSliderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //保存当前皮肤
    self.skinAddress = [[NSUserDefaults standardUserDefaults] objectForKey:@"skinAddress"];
    
    //1.configTableView
    [self configTableView];
    //2.设置启动皮肤
    [self changeSkin];
    //3.添加换肤监听
    [self addNotificationCenter];
    //4.监听登录成功状态，改变头像和名字
    [self configNotifiCationCenter];
    
    
}
#pragma mark - lazyLoad
- (NSArray *)cellImageNameArray{

    if (_cellImageNameArray == nil) {
        
        _cellImageNameArray = @[/*@"sidemenu_QA",@"sidemenu-software",*/@"sidemenu_blog",@"sidemenu_setting",@"sidemenu-night"];
    }
    return _cellImageNameArray;
}
- (NSArray *)cellTitleArray{

    if (_cellTitleArray == nil) {
#warning message 阉割
        _cellTitleArray = @[/*@"我的下载",@"我的收藏",*/@"换肤",@"设置"/*,@"夜间模式"*/];
    }
    return _cellTitleArray;
}
#pragma mark - setupUI
//配置tableView
- (void)configTableView{
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"sliderCellID"];
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 180;
}

- (void)addNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSkin) name:@"changeSkin" object:nil];
}
- (void)changeSkin{
    
    NSString *addressPre =  [[NSUserDefaults standardUserDefaults] objectForKey:@"skinAddress"];
    
    NSString *skinPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/themeColor.plist",addressPre] ofType:nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:skinPath];
    
    NSArray *rgbArray = [dict[@"navigationColor"] componentsSeparatedByString:@","];
    
    self.tableView.backgroundColor = JColorRGBA([rgbArray[0] floatValue], [rgbArray[1]floatValue], [rgbArray[2]floatValue],0.6);
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.cellTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //复用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sliderCellID" forIndexPath:indexPath];
    
    
    //修改背景颜色
    // Configure the cell...
    cell.imageView.image = [UIImage imageNamed:self.cellImageNameArray[indexPath.row]];
    cell.textLabel.text = self.cellTitleArray[indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.000];
    
    return cell;

}
#pragma mark - tableView代理相关
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    //添加表头视图
    UIView *headView = [[UIView alloc] init];
//    headView.backgroundColor = JColorAlert;
    headView.frame = CGRectMake(0, 0, JScreenWidth, 180);
    
    
    UIImageView *headerBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth * 0.8, 180)];
    [headView addSubview:headerBG];
    headerBG.image = [UIImage imageNamed:@"HeaderBG01"];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 45, 80, 80)];
    [headView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    imageView.layer.cornerRadius = 40;
    imageView.layer.masksToBounds = YES;
    imageView.backgroundColor = [UIColor grayColor];
    imageView.userInteractionEnabled = YES;
    
    self.headerImageView = imageView;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped)];
    [imageView addGestureRecognizer:tapGR];
    
    //名字label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, 200, 30)];
    nameLabel.text = @"点击头像登录";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:nameLabel];
    
    self.userNameLabel = nameLabel;
    
    return headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 跳转事件
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *ctrl = nil;
    NSInteger row = indexPath.row;
    switch (row) {
#warning message 阉割侧边栏
//        case 0://我的下载
//            ctrl = nil;
//            break;
//            
//        case 1://我的收藏
//            break;
            
        case 0://我的皮肤
            ctrl = [[XHDDOnlineMineSkinController alloc] init];
            break;
            
        case 1://
            ctrl = [[XHDDOnlineSettingController alloc] init];
            break;
            
//            case 4://夜间模式
//        {//取出沙盒当前的皮肤，存起来，然后放进去夜间模式的皮肤，发个通知。OK！
//            return;
//        }
//            break;
        default:
            break;
    }
    
    [[XHUtils getCurrentTabBarNavigationCtrl] pushViewController:ctrl animated:NO];
    
    [self.sideMenuViewController hideMenuViewController];
}
- (void)taped{
    JLog(@"点击了头像");
    //如果已经登录，则调到zone， 否则去登录
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] boolValue]) {//已经登录
        
      XHDDOnlineRootTabBarController *rootTbc =  self.sideMenuViewController.contentViewController.childViewControllers[0];
        rootTbc.selectedIndex = rootTbc.childViewControllers.count - 1;
        
        [self.sideMenuViewController hideMenuViewController];
        
        return;
    }
    
    XHDDOnlineSignInController *signCtrl = [[XHDDOnlineSignInController alloc] init];
    XHDDOnlineRootTabBarController *rootTbc = self.sideMenuViewController.contentViewController.childViewControllers[0];
    UINavigationController *nav = rootTbc.selectedViewController;
    
    [nav pushViewController:signCtrl animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}
#pragma mark - 监听登录
- (void)configNotifiCationCenter{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed) name:@"loginSucceed" object:nil];
}
- (void)loginSucceed{

    self.userNameLabel.text = [EMClient sharedClient].currentUsername;
    //存储路径
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"userHeaderImage"]];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data == nil) {
        self.headerImageView.image = [UIImage imageNamed:@"selfHeaderImage"];
        return;

    }
    self.headerImageView.image = [UIImage imageWithData:data];
    
}

//- (void)nightSwitchClick:(UISwitch *)nightSwitch{
//   
//    nightSwitch.on = !(nightSwitch.isOn);
//    
//    //取出沙盒当前的皮肤，存起来，然后放进去夜间模式的皮肤，发个通知。OK！
//    
//    if (nightSwitch.isOn) {//夜间模式
//        //发送夜间皮肤
//        [[NSUserDefaults standardUserDefaults] setObject:@"teamTheme/nightType" forKey:@"skinAddress"];
//    }
//    else{
//        //发送原皮肤
//        [[NSUserDefaults standardUserDefaults] setObject:self.skinAddress forKey:@"skinAddress"];
//    }
//    
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSkin" object:nil];
//
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
