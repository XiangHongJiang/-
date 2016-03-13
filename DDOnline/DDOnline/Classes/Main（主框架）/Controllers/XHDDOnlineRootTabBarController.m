//
//  XHDDOnlineRootTabBarController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//
/**
 侧边栏控制器，用于侧边栏的视图展示及功能实现
 */
#import "XHDDOnlineRootTabBarController.h"
#import "XHDDOnlineRootNavigationController.h"

@interface XHDDOnlineRootTabBarController ()<UITabBarControllerDelegate>

/**
 *  addButton
 */
@property (nonatomic, weak) UIButton * addButton;

@end

@implementation XHDDOnlineRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1.添加带导航的视图控制器
    [self addSubCtrlWithNav];
    
    //设置自己为代理来实现按钮控制
    self.delegate = self;

    //2.添加加号按钮
    [self addAddButton];
}
#pragma mark - setupUI
//添加
- (void)addSubCtrlWithNav{

    //管理的子视图控制器的名字数组，用于快速创建
    NSArray *vcNameArray = @[@"FunPlay", @"Joke",@"",@"Chat", @"Mine"];
    NSArray *titleNameArray = @[@"每日一看", @"每日一笑", @"",@"每日一聊", @"Zone"];
    for (int i = 0; i < vcNameArray.count; i ++) {
        //设置第三页为空页
        if (i == 2) {
            
            [self addChildViewController:[[UIViewController alloc] init]];
            continue;
        }
        
        //拼接名字
        NSString *name = [NSString stringWithFormat:@"XHDDOnline%@Controller", vcNameArray[i]];
        //获取类
        Class clazz = NSClassFromString(name);
        //创建控制器
        UIViewController *vc = [[clazz alloc] init];
        
        //获取标题
        NSString *title = titleNameArray[i];
        
        //获取图片
        NSString *imageName = [NSString stringWithFormat:@"TabBar_Client_%d_n",i+1];
        NSString *selectedImageName = [NSString stringWithFormat:@"TabBar_Client_%d_p",i+1];
        
        if (i > 2) {
            imageName = [NSString stringWithFormat:@"TabBar_Client_%d_n",i];
            selectedImageName = [NSString stringWithFormat:@"TabBar_Client_%d_p",i];
        }
        //添加带导航的控制器：设置标题，图片
        [self addNavToViewController:vc withTitle:title imageName:imageName selectedImageName:selectedImageName];
        
    }
    
}
//添加设置
- (void)addNavToViewController:(UIViewController *)viewController withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    //创建导航
    XHDDOnlineRootNavigationController *nav = [[XHDDOnlineRootNavigationController alloc] initWithRootViewController:viewController];
    //设置标题
    viewController.navigationItem.title = title;
    viewController.view.backgroundColor = JColorLightGray;
    //设置Item图标
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //添加
    [self addChildViewController:nav];

}
//添加加号按钮
- (void)addAddButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:button];
    //set
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar-more"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor]];
    button.frame = CGRectMake(0, 0, JTabBarHeight * 0.6, JTabBarHeight * 0.6);
    button.center = CGPointMake(JScreenWidth * 0.5, JTabBarHeight * 0.5);
    button.layer.cornerRadius = JTabBarHeight * 0.3;
    self.addButton = button;

    
}
#pragma mark - response
- (void)addAdction:(UIButton *)btn{
#warning 弹出分享视图在windows上
    NSLog(@"点击了中间加号按钮");
}
#pragma mark - UITabBarControllerDelegate
//设置第三页不可点击
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    NSArray *array = tabBarController.viewControllers;
    NSUInteger index = [array indexOfObject:viewController];
    
    if (index == 2) {//第3个页面不可选中
        [self addAdction:self.addButton];
        return NO;
    }
    
    return YES;
}


@end
