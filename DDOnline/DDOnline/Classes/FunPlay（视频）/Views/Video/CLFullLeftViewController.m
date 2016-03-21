//
//  CLFullLeftViewController.m
//  AVPlayer
//
//  Created by user on 16/3/4.
//  Copyright © 2016年 夏成龙. All rights reserved.
//

#import "CLFullLeftViewController.h"

@interface CLFullLeftViewController ()
/**
 *  <#Description#>
 */
@property (nonatomic, assign) BOOL isHidenBar;
@end

@implementation CLFullLeftViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    //设置当前视图的大小
     self.view.bounds = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    //将视图控制器旋转90度
    [UIView animateWithDuration:0.3 animations:^{
         self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    } completion:nil];
    
//    self.navigationController.prefersStatusBarHidden = YES;
    
}

//设置允许当前控制横屏
- (BOOL)shouldAutorotate{
    
    return YES;
}

//设置横屏的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskAll;
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.isHidenBar = self.navigationController.navigationBarHidden;
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = self.isHidenBar;
}

@end
