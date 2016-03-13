//
//  XHDDOnlineJokeCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeCell.h"

#import "XHDDOnlineJokePureTextModel.h"
#import "XHDDOnlineJokeGifModel.h"
#import "XHDDOnlineJokeVideoModel.h"
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
/** *  XHDDOnlineJokePureTextModel */
@property (nonatomic, strong) XHDDOnlineJokePureTextModel * jokePureTextModel;
/** *  XHDDOnlineJokeGifModel */
@property (nonatomic, strong) XHDDOnlineJokeGifModel *jokeGifModel;
/** *  XHDDOnlineJokeVideoModel */
@property (nonatomic, strong) XHDDOnlineJokeVideoModel *jokeVideoModel;

@end

@implementation XHDDOnlineJokeCell
#pragma mark -添加刷新
- (void)awakeFromNib {
    //添加刷新
    [self addRefresh];
}
#pragma mark -根据传进来的类型，进行数据请求
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
    //请求数据
    [self requestData];
}
#pragma mark - 添加刷新
- (void)addRefresh{
    //添加下拉刷新
    self.jokeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    //添加上啦加载
    self.jokeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}
#pragma mark - 上啦加载
- (void)requestMoreData{

       _requestCount += 20;
    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    
    [XHNetHelp getDataWithPath:[NSString stringWithFormat:self.jokeUrlStr,_requestCount] andParams:nil andComplete:^(BOOL succeed, id result) {
        
        if (succeed) {
            
            NSDictionary *modelDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            
            //根据传进来的类型进行不同数据的加载
//            XHDDOnlineJokeBaseModel *jokeBaseModel = [XHDDOnlineJokeBaseModel jokeBaseModelWithJokeType:self.jokeType andDict:modelDict];
//            
//            weakSelf.jokeBaseModel = jokeBaseModel;

            //存储数据模型
            [self modelWithDict:modelDict];
            
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
#pragma mark - 请求数据,下拉刷新
- (void)requestData{

    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    
    [XHNetHelp getDataWithPath:[NSString stringWithFormat:self.jokeUrlStr,20] andParams:nil andComplete:^(BOOL succeed, id result) {
      
        if (succeed) {
            
             _requestCount = 20;
            
            NSDictionary *modelDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            
            //存储数据模型
            [weakSelf modelWithDict:modelDict];
            
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
//存储数据模型
- (void)modelWithDict:(NSDictionary *)modelDict{
    
    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    //根据传进来的类型进行不同数据的加载
    switch (self.jokeType) {
            
        case JokeTypeDuanzi:{//段子
           
            XHDDOnlineJokePureTextModel *jokePureTextModel =            [XHDDOnlineJokePureTextModel mj_objectWithKeyValues:modelDict];
            
            weakSelf.jokePureTextModel = jokePureTextModel;
        }
            break;
            
        case JokeTypeGif:{//图
            XHDDOnlineJokeGifModel *jokeGifModel = [XHDDOnlineJokeGifModel mj_objectWithKeyValues:modelDict];
            weakSelf.jokeGifModel = jokeGifModel;
            
        }
            break;
            
        case JokeTypeVideo:{//短片
            XHDDOnlineJokeVideoModel *jokeVideoModel =            [XHDDOnlineJokeVideoModel mj_objectWithKeyValues:modelDict];
            weakSelf.jokeVideoModel = jokeVideoModel;
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _requestCount;//self.jokeBaseModel.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    switch (self.jokeType) {
        case JokeTypeDuanzi:{
           
           cell = [XHDDOnlineJokePureTextCell jokePureTextCellWithTableView:tableView];
            XHDDOnlineJokePureTextCell *pureTextCell = (XHDDOnlineJokePureTextCell *)cell;
            pureTextCell.pureTextDetailModel = self.jokePureTextModel.list[indexPath.row];
            
        }
            break;
        case JokeTypeGif:{
        
            XHDDOnlineJokeGifCell *cell = [XHDDOnlineJokeGifCell jokeGifCellWithTableView:tableView];
            cell.gifDetailModel = self.jokeGifModel.list[indexPath.row];

            return cell;
        }
            break;
        case JokeTypeVideo:{
            
            XHDDOnlineJokeVideoCell *cell = [XHDDOnlineJokeVideoCell jokeVideoCellWithTableView:tableView];
            cell.videoDetailModel = self.jokeVideoModel.list[indexPath.row];
            
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
            rowHeight = [XHDDOnlineJokePureTextCell rowHeightWithPureTextDetailModel:self.jokePureTextModel.list[indexPath.row]];
        }break;
            
            case JokeTypeGif:
            rowHeight = [XHDDOnlineJokeGifCell rowHeightWithgifDetailModel:self.jokeGifModel.list[indexPath.row]];
            break;
            
            case JokeTypeVideo:
            rowHeight = [XHDDOnlineJokeVideoCell rowHeightWithvideoDetailModel:self.jokeVideoModel.list[indexPath.row]];
            break;
        default:
            break;
    }
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    XHDDOnlineJokeDetailController *jokeDetailCtrl = [[XHDDOnlineJokeDetailController alloc] init];
    
    
    switch (self.jokeType) {
        case JokeTypeDuanzi:
            jokeDetailCtrl.pureTextDetailModel = self.jokePureTextModel.list[indexPath.row];
            break;
            case JokeTypeGif:
            jokeDetailCtrl.gifDetailModel = self.jokeGifModel.list[indexPath.row];
            break;
            case JokeTypeVideo:
            jokeDetailCtrl.videoDetailModel = self.jokeVideoModel.list[indexPath.row];
            break;
            
        default:
            break;
    }

    [self.viewController.navigationController pushViewController:jokeDetailCtrl animated:NO];
    
}

@end
