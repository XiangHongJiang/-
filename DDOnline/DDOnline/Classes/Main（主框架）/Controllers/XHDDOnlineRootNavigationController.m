//
//  XHDDOnlineRootNavigationController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineRootNavigationController.h"
#import "RESideMenu.h"

@interface XHDDOnlineRootNavigationController ()

@end

@implementation XHDDOnlineRootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置启动皮肤
    [self changeSkin];

    //添加换肤监听
    [self addNotificationCenter];

}
- (void)addNotificationCenter{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSkin) name:@"changeSkin" object:nil];
}
- (void)changeSkin{

    NSString *addressPre =  [[NSUserDefaults standardUserDefaults] objectForKey:@"skinAddress"];
    
    NSString *skinPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/themeColor.plist",addressPre] ofType:nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:skinPath];
    
    NSArray *rgbArray = [dict[@"navigationColor"] componentsSeparatedByString:@","];
    
    self.navigationBar.barTintColor = JColorRGB([rgbArray[0] floatValue], [rgbArray[1]floatValue], [rgbArray[2]floatValue]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count == 0) {
        
        //添加侧边栏按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navicon-40"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(splite)];
        //添加扫一扫功能
#warning 添加扫一扫功能
   /*
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"find-40"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
    */

//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:<#(nonnull UIView *)#>]
    }
    
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //设置多层推出时隐藏TabBar
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed= YES;
    }

    [super pushViewController:viewController animated:animated];
    
}
- (void)splite{
    
    //侧边栏展开
    [self.sideMenuViewController presentLeftMenuViewController];
}
//扫描
- (void)scan{

    JLog(@"进入扫描");
    
}

@end
