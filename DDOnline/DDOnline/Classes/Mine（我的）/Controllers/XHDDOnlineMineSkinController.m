//
//  XHDDOnlineMineSkinController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineMineSkinController.h"
#import "XHDDOnlineMineSkinModel.h"
#import "XHDDOnlineMineSkinCell.h"

@interface XHDDOnlineMineSkinController ()
/**
 *  skinModelArray
 */
@property (nonatomic, copy) NSArray *skinModelArray;
/**
 * lastCellBtn
 */
@property (nonatomic, weak) UIButton * lastCellBtn;
@end

@implementation XHDDOnlineMineSkinController

//获取数据源
- (NSArray *)skinModelArray{

    if (_skinModelArray == nil) {
        
       NSMutableArray *mArray = [NSMutableArray array];
    
       NSString *path = [[NSBundle mainBundle] pathForResource:@"Theme" ofType:@"plist"];
        
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
        
        for (int i = 0; i < dataArray.count; i ++) {
            
            XHDDOnlineMineSkinModel *model = [XHDDOnlineMineSkinModel skinWithDict:dataArray[i]];
            
            [mArray addObject:model];
            
        }
        _skinModelArray = mArray;
    }
    return _skinModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.bounces = NO;
    
    //注册Cell
    [self registCell];

}
-(void)registCell{

    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineMineSkinCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineMineSkinCell"];
}
#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.skinModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XHDDOnlineMineSkinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineMineSkinCell"];
    
    NSString *theme = [[NSUserDefaults standardUserDefaults]objectForKey:@"skinAddress"];
    
    XHDDOnlineMineSkinModel *model = self.skinModelArray[indexPath.row];
    
    if ([[model address] isEqualToString:theme]) {
        self.lastCellBtn = cell.leftBtn;
    }
    
    cell.skinModel = self.skinModelArray[indexPath.row];
 
    return cell;
}
#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.lastCellBtn.selected = NO;
    //设置选中状态
    XHDDOnlineMineSkinCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.leftBtn.selected = YES;
    self.lastCellBtn = cell.leftBtn;
    
    //设置沙盒
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[self.skinModelArray[indexPath.row] address] forKey:@"skinAddress"];
    [ud synchronize];
    
    //设置通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSkin" object:nil];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 75;
}

@end
