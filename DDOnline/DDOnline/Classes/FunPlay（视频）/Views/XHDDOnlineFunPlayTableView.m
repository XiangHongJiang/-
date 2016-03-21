//
//  XHDDOnlineFunPlayTableView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFunPlayTableView.h"
#import "XHDDOnlineFunPlayLatestCell.h"
#import "XHDDOnlineFunPlayHeaderView.h"
#import "XHDDOnlineCategorysCell.h"
#import "XHDDOnlineRecommendCategorysCell.h"

@interface XHDDOnlineFunPlayTableView()<UITableViewDataSource, UITableViewDelegate>

/**
 *  collectionView
 */
@property (nonatomic, weak) UICollectionView *cellCollectionView;

@end

@implementation XHDDOnlineFunPlayTableView

+ (instancetype)funPlayTableView{

    //创建对象
    XHDDOnlineFunPlayTableView *funPlayTableView = [[XHDDOnlineFunPlayTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //设置代理
    funPlayTableView.delegate = funPlayTableView;
    funPlayTableView.dataSource = funPlayTableView;
    
    funPlayTableView.showsVerticalScrollIndicator = NO;
    funPlayTableView.showsHorizontalScrollIndicator = NO;
    
    funPlayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
//    [funPlayTableView registerNib:[UINib nibWithNibName:@"XHDDOnlineCategorysCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineCategorysCell"];
    
    return funPlayTableView;
}

- (void)setFunPlayModel:(XHDDOnlineFunPlayModel *)funPlayModel{
    _funPlayModel = funPlayModel;
    
    //刷新数据
    [self reloadData];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{

    self.backgroundColor = JColorNavBg;
    self.frame = CGRectMake(0, 0,newSuperview.frame.size.width, newSuperview.frame.size.height-8);
}
#pragma mark - tableView Delegate
/** 返回组数    */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.funPlayModel.result.categories.count + 2;
}
/**  返回行数   */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;//self.funPlayDataArray.count;
}
/**  返回tableViewCell    */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section == 0) {//第0组
    
        XHDDOnlineFunPlayLatestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineFunPlayLatestCell"];
        if (cell == nil) {
            
            cell = [[XHDDOnlineFunPlayLatestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHDDOnlineFunPlayLatestCell"];
        }
        cell.latestModel = self.funPlayModel.result.latestUpdate;
        
        self.cellCollectionView = cell.cellCollectionView;
 
        return cell;
    }
    else if(indexPath.section == 1){//第一组
    
        XHDDOnlineRecommendCategorysCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineRecommendCategorysCell"];
        
        if (cell == nil) {
            
            cell = [[XHDDOnlineRecommendCategorysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHDDOnlineRecommendCategorysCell"];
        }
       
        cell.recommendCategory = self.funPlayModel.result.recommendCategory;
        
        return cell;

    }
    else{//其他组
          XHDDOnlineCategorysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineCategorysCell"];
        if (cell == nil) {
            
            cell = [[XHDDOnlineCategorysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHDDOnlineCategorysCell"];
        }
        cell.categoryModel = self.funPlayModel.result.categories[indexPath.section - 2];
        
        return cell;
    }


}
/** 返回重复利用的组头*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    XHDDOnlineFunPlayHeaderView *headerView = [XHDDOnlineFunPlayHeaderView headerViewWithTableView:tableView];
    
    if (section == 0) {
        
        headerView.headerImageView.image = [UIImage imageNamed:@"home_region_icon_33"];
        headerView.nameLabel.text = @"新番连载";
        
    }
    else if(section == 1){
        
        headerView.headerImageView.image = [UIImage imageNamed:@"home_region_icon_32"];
        headerView.nameLabel.text = @"分类推荐";
    }
    else
    {
        headerView.headerImageView.image = [UIImage imageNamed:@"home_region_icon_34"];
        
        CategoriesModel *category =self.funPlayModel.result.categories[section - 2];
        headerView.nameLabel.text = category.category.tag_name;
    }
        
    return headerView;
}
#warning 消耗性能
/** 返回组头高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}
/** 返回行高*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 320;
    }
    return 200;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    XHDDOnlineFunPlayLatestCell *cell =
 
    if (self.cellCollectionView.contentOffset.y >= 0) {
        
        self.cellCollectionView.scrollEnabled = YES;
    }
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
