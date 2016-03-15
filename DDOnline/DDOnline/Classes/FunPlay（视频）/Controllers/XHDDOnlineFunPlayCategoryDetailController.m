//
//  XHDDOnlineFunPlayCategoryDetailController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/10.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFunPlayCategoryDetailController.h"
#import "XHDDOnlineCategoryDetailModel.h"
#import "XHDDOnlineCategorysDetailCell.h"
#import "XHDDOnlineRootTabBarController.h"
#import "XHDDOnlineFunPlayDeatailController.h"

@interface XHDDOnlineFunPlayCategoryDetailController ()

/** *  详情数据XHDDOnlineFunPlayDetailModel */
@property (nonatomic, strong) XHDDOnlineCategoryDetailModel * categoryDetailModel;
@end

@implementation XHDDOnlineFunPlayCategoryDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineCategorysDetailCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineCategorysDetailCell"];
  
    //1.请求数据
    [self requestData];
}
#pragma mark - requestData
- (void)requestData{
    
    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    
    [XHNetHelp getDataWithPath:[NSString stringWithFormat:kFunPlayCategoryDetailUrl,self.tag_id] andParams:nil andComplete:^(BOOL succeed, id result) {
        
        if (succeed) {//请求成功

            //            //解析
            NSDictionary *categoryDetailModelDic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            //
            //            //转模型
            XHDDOnlineCategoryDetailModel *categoryDetailModel = [XHDDOnlineCategoryDetailModel mj_objectWithKeyValues:categoryDetailModelDic];
 
            //            //赋值模型
            weakSelf.categoryDetailModel = categoryDetailModel;

            //            //赋值刷新
            [weakSelf.tableView reloadData];
            
        }
        else{//请求失败
            
            NSLog(@"请求失败:%@",result);
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.categoryDetailModel.result.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    XHDDOnlineCategorysDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineCategorysDetailCell" forIndexPath:indexPath];
    
    cell.detailModel = self.categoryDetailModel.result[indexPath.row];
    
    cell.backgroundColor = JColorNavBg;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    XHDDOnlineFunPlayDeatailController *detailCtrl = [[XHDDOnlineFunPlayDeatailController alloc] init];
   
    detailCtrl.season_id = [self.categoryDetailModel.result[indexPath.row] season_id];
    
    detailCtrl.view.backgroundColor = JColorNavBg;

    [self.navigationController pushViewController:detailCtrl animated:YES];
    
}


@end
