//
//  XHDDOnlineFunPlayDetailNumberCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/9.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFunPlayDetailNumberCell.h"
#import "XHDDOnlineRootTabBarController.h"
#import "XHDDOnlineFunPlayPlayVideoController.h"

@interface XHDDOnlineFunPlayDetailNumberCell()
/**
 *  cidArray
 */
@property (nonatomic, copy) NSMutableArray *cidArray;

@end

static CGFloat rowHeight;

@implementation XHDDOnlineFunPlayDetailNumberCell

- (void)setDetailFunPlayArray:(NSArray *)detailFunPlayArray{
    
    _detailFunPlayArray = detailFunPlayArray;
    
    self.cidArray = [NSMutableArray new];
    
    int count = (int)detailFunPlayArray.count;
    
    // 确定总列数
    int totoalCol = 4;
    CGFloat margin = 10;
    
    // 确定尺寸
    CGFloat itemW = (JScreenWidth - margin * 5) / totoalCol;
    CGFloat itemH = itemW * 0.5;
    
    for (int i = 0; i < count; i ++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //确定行列
        int row = i / totoalCol;
        int col = i % totoalCol;
        
        //确定XY
        CGFloat itemX = margin + col * (margin + itemW);
        CGFloat itemY = margin + row * (margin + itemH);
        
        button.frame = CGRectMake(itemX, itemY, itemW, itemH);
        //title
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
        button.layer.borderColor = JColorLightGray.CGColor;
        
        button.tag = JDefaultTag + i;
        
        [self.contentView addSubview:button];
        
        if (i == count - 1) {
            
            rowHeight = itemY + itemH + margin;
        }
    }

}
- (void)setFunPlayDesc:(NSString *)funPlayDesc{

    _funPlayDesc = funPlayDesc;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, JScreenWidth - 20, JScreenHeight)];
    [self.contentView addSubview:label];
    label.text = funPlayDesc;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
    
    rowHeight = label.frame.size.height + 20;
}
//点击
- (void)btnClick:(UIButton *)btn{
    [btn setTitleColor:JColorGray forState:UIControlStateNormal];
    

    Episodes *episodes = self.detailFunPlayArray[btn.tag - JDefaultTag];
    NSString *aid = episodes.av_id;
 
    XHDDOnlineFunPlayPlayVideoController *funPlayVideoCtrl = [[XHDDOnlineFunPlayPlayVideoController alloc] init];
    funPlayVideoCtrl.aid = aid;
    
    //推出控制器
    RESideMenu *sideMenu = (RESideMenu *)[UIApplication sharedApplication].keyWindow.rootViewController;
    XHDDOnlineRootTabBarController *tbc = sideMenu.contentViewController.childViewControllers[0];
    UINavigationController *nav = (UINavigationController *)tbc.selectedViewController;
    [nav pushViewController:funPlayVideoCtrl animated:YES];
    
//    JLog(@"播放视频%ld",btn.tag - JDefaultTag + 1);
}
//返回行高
+ (CGFloat)rowHeight{

    return rowHeight;
}
@end
