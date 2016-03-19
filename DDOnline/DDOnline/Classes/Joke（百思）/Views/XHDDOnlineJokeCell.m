//
//  XHDDOnlineJokeCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeCell.h"

#import "XHDDOnlineJokeBaseModel.h"

#import "XHDDOnlineJokePureTextCell.h"
#import "XHDDOnlineJokeGifCell.h"
#import "XHDDOnlineJokeVideoCell.h"

#import "XHDDOnlineJokeDetailController.h"



@interface XHDDOnlineJokeCell()<UITableViewDataSource, UITableViewDelegate>
{
    int _requestCount;
}
/** *  JokeUrlStr */
@property (nonatomic, copy) NSString *jokeUrlStr;
/* *  jokeTableView */
@property (weak, nonatomic) IBOutlet UITableView *jokeTableView;
/** *  jokeBaseModel */
@property (nonatomic, strong) XHDDOnlineJokeBaseModel *jokeBaseModel;

@end

@implementation XHDDOnlineJokeCell
#pragma mark -添加刷新
- (void)awakeFromNib {
    //添加刷新
    [self addRefresh];
}
#pragma mark - 添加刷新
- (void)addRefresh{
    //添加下拉刷新
    self.jokeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    //添加上啦加载
    self.jokeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}
#pragma mark - 根据传进来的类型，进行数据请求
- (void)setJokeType:(JokeType)jokeType{
    _jokeType = jokeType;
    
    switch (jokeType) {
        case JokeTypeDuanzi:
            self.jokeUrlStr = kJokePureTextUrl;
            break;
            
            case JokeTypeGif:
            self.jokeUrlStr = kJokeGifUrl;
            break;
            
            case JokeTypeVideo:
            self.jokeUrlStr = kJokeVideoUrl;
            break;
        default:
            break;
    }
    
    [self requestData];
}
#pragma mark - 请求数据,下拉刷新
- (void)requestData{

    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    
    [XHNetHelp getDataWithPath:[NSString stringWithFormat:self.jokeUrlStr,20] andParams:nil andComplete:^(BOOL succeed, id result) {
        if (succeed) {
            
             _requestCount = 20;
            NSDictionary *modelDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
 
            //存储数据模型
            XHDDOnlineJokeBaseModel *jokeBaseModel = [XHDDOnlineJokeBaseModel mj_objectWithKeyValues:modelDict];
            
            weakSelf.jokeBaseModel = jokeBaseModel;
            
            //停止刷新
            [weakSelf.jokeTableView.mj_header endRefreshing];
            
            //刷新tableView
            [weakSelf.jokeTableView reloadData];
            
        }
        else{
        
            JLog(@"请求失败：%@",result);
        }
    }];
}
#pragma mark - 上啦加载
- (void)requestMoreData{
    
    _requestCount += 20;
    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    
    [XHNetHelp getDataWithPath:[NSString stringWithFormat:self.jokeUrlStr,_requestCount] andParams:nil andComplete:^(BOOL succeed, id result) {
        
        if (succeed) {
            NSDictionary *modelDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            
            //存储数据模型
            XHDDOnlineJokeBaseModel *jokeBaseModel = [XHDDOnlineJokeBaseModel mj_objectWithKeyValues:modelDict];
            
            weakSelf.jokeBaseModel = jokeBaseModel;
            
            //停止刷新
            [weakSelf.jokeTableView.mj_footer endRefreshing];
            
            //刷新tableView
            [weakSelf.jokeTableView reloadData];
            
        }
        else{
            JLog(@"请求失败：%@",result);
        }
    }];
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.jokeBaseModel.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    switch (self.jokeType) {
        case JokeTypeDuanzi:{
           
           cell = [XHDDOnlineJokePureTextCell jokePureTextCellWithTableView:tableView];
            XHDDOnlineJokePureTextCell *pureTextCell = (XHDDOnlineJokePureTextCell *)cell;
            pureTextCell.pureTextDetailModel = self.jokeBaseModel.list[indexPath.row];
            
        }
            break;
        case JokeTypeGif:{
        
            XHDDOnlineJokeGifCell *cell = [XHDDOnlineJokeGifCell jokeGifCellWithTableView:tableView];
            cell.gifDetailModel = self.jokeBaseModel.list[indexPath.row];

            return cell;
        }
            break;
        case JokeTypeVideo:{
            
            XHDDOnlineJokeVideoCell *cell = [XHDDOnlineJokeVideoCell jokeVideoCellWithTableView:tableView];
            cell.videoDetailModel = self.jokeBaseModel.list[indexPath.row];
            
            return cell;
        }
            break;
    }

    return cell;
}
#pragma mark - tableView delegate
//返回每个cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = 0;
    switch (self.jokeType) {
            
        case JokeTypeDuanzi:{
            rowHeight = [XHDDOnlineJokePureTextCell rowHeightWithPureTextDetailModel:self.jokeBaseModel.list[indexPath.row]];
        }break;
            
            case JokeTypeGif:
            rowHeight = [XHDDOnlineJokeGifCell rowHeightWithgifDetailModel:self.jokeBaseModel.list[indexPath.row]];
            break;
            
            case JokeTypeVideo:
            rowHeight = [XHDDOnlineJokeVideoCell rowHeightWithvideoDetailModel:self.jokeBaseModel.list[indexPath.row]];
            break;
        default:
            break;
    }
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    XHDDOnlineJokeDetailController *jokeDetailCtrl = [[XHDDOnlineJokeDetailController alloc] init];
    
    //传入模型和类型
    jokeDetailCtrl.jokeBaseDetailModel = self.jokeBaseModel.list[indexPath.row];
    jokeDetailCtrl.jokeType = self.jokeType;
    
    [self.viewController.navigationController pushViewController:jokeDetailCtrl animated:NO];
    
}

@end
