//
//  XHDDOnlineFunPlayDeatailController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/8.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFunPlayDeatailController.h"
#import "XHDDOnlineFunPlayDetailModel.h"
#import "XHDDOnlineFunPlayDetailNumberCell.h"

@interface XHDDOnlineFunPlayDeatailController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
/** *  详情数据XHDDOnlineFunPlayDetailModel */
@property (nonatomic, strong) XHDDOnlineFunPlayDetailModel * funPlayDetailModel;
/** *  headerImageView */
@property (nonatomic, weak) UIImageView * headerImageView;
/** *  titleLabel */
@property (nonatomic, weak) UILabel * titleLabel;
/** *  descLabel */
@property (nonatomic, weak) UILabel * descLabel;

@end

@implementation XHDDOnlineFunPlayDeatailController

- (void)loadView{
    [super loadView];
    
    //1.添加tableView
    [self addTableView];
    
    //2.添加表头
    [self addTableViewHeaderView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //1. 请求数据
    [self requestData];
    
}
#pragma mark - setupUI
- (void)addTableView{

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, JTopSpace, JScreenWidth, JScreenHeight - JTopSpace)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //delegate
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;
    
    tableView.backgroundColor = JColorLightGray;
    
    
}
//添加表头
- (void)addTableViewHeaderView{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, 150)];
   
    headerView.backgroundColor = JColorLightGray;
    //imageView
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.backgroundColor = JColorLightGray;
    headerImageView.layer.cornerRadius = 5;
    headerImageView.layer.masksToBounds = YES;
    self.headerImageView = headerImageView;
    
    [headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(10);
        make.left.equalTo(10);
        make.bottom.equalTo(-10);
        make.width.equalTo(110);
    }];
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    [headerView addSubview:titleLabel];
//    titleLabel.backgroundColor = JColorLightGray;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel adjustsFontSizeToFitWidth];
    [titleLabel setTextColor:[UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000]];
    
    self.titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(10);
        make.left.equalTo(headerImageView.mas_right).offset(10);
        make.height.equalTo(30);
        make.right.equalTo(0);
        
    }];
    
    //descLabel
    UILabel *descLabel = [[UILabel alloc] init];
    [headerView addSubview:descLabel];
    descLabel.font = [UIFont systemFontOfSize:13];
//    descLabel.backgroundColor = JColorLightGray;
    self.descLabel = descLabel;
    descLabel.textAlignment = NSTextAlignmentCenter;

    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.equalTo(headerImageView.mas_right).offset(10);
        make.height.equalTo(30);
        make.right.equalTo(0);
        
    }];
    
    
    
    //设置表头
    self.tableView.tableHeaderView = headerView;
    
}
#pragma mark - requestData
- (void)requestData{

    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    
    [XHNetHelp getDataWithPath:[NSString stringWithFormat:kFunPlayDetailUrl,self.season_id] andParams:nil andComplete:^(BOOL succeed, id result) {
        
        if (succeed) {//请求成功
            
            //解析数据
            NSData *data = [self dataWithData:result];

//            //解析
            NSDictionary *funPlayDetailDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//            //转模型
            XHDDOnlineFunPlayDetailModel *funPlayDetailModel = [XHDDOnlineFunPlayDetailModel mj_objectWithKeyValues:funPlayDetailDict];
//
//            //赋值模型
            weakSelf.funPlayDetailModel = funPlayDetailModel;
            
            //刷新tableHeadView
            [weakSelf refreshTableHeaderView];

//          //赋值刷新
            [weakSelf.tableView reloadData];
        
        }
        else{//请求失败
            
            NSLog(@"请求失败:%@",result);
        }
        
    }];

}
//解析字符串，存储模型
- (NSData *)dataWithData:(NSData *)result{

    NSMutableString *mString = [[NSMutableString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
    NSRange range = [mString rangeOfString:@"episodeJsonCallback("];

    [mString deleteCharactersInRange:range];
    
    [mString deleteCharactersInRange:NSMakeRange(mString.length - 2, 2)];
    
//    JLog(@"%@",mString);
    
    NSData *data = [mString dataUsingEncoding:NSUTF8StringEncoding];
    return data;
    
}

#pragma mark - 刷新表头
- (void)refreshTableHeaderView{

    self.titleLabel.text = self.funPlayDetailModel.result.bangumi_title;
    
    NSString *play;
    NSString *favo;
    
    NSString *play_count = self.funPlayDetailModel.result.play_count;
    NSString *favorites = self.funPlayDetailModel.result.favorites;
    float playCount = [play_count intValue] / 10000.0;
    float favoritesCount = [favorites intValue] / 10000.0;
    
    if (playCount > 1.0) {
        
        play = [NSString stringWithFormat:@"播放: %.2f万",playCount];
    }
    else{
    
        play = [NSString stringWithFormat:@"播放: %@",play_count];
    }
    
    if (favoritesCount > 1.0) {
        
        favo = [NSString stringWithFormat:@"追番:%.2f万",favoritesCount];
    }
    else{
    
        favo = [NSString stringWithFormat:@"追番: %@",favorites];
    }
    
    self.descLabel.text = [NSString stringWithFormat:@"%@  %@",play,favo];//play_count，favorites
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.funPlayDetailModel.result.cover]];

}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
//返回cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
//返回btn数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XHDDOnlineFunPlayDetailNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineFunPlayDetailNumberCell"];
    
    if (cell == nil) {
        
        cell = [[XHDDOnlineFunPlayDetailNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHDDOnlineFunPlayDetailNumberCell"];
    }
    
    if (indexPath.section == 0) {
        cell.detailFunPlayArray = self.funPlayDetailModel.result.episodes;
    }
    else{
        
        cell.funPlayDesc = self.funPlayDetailModel.result.evaluate;
    }

    cell.backgroundColor = JColorLightGray;
    
    return cell;
    
}
//返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    if (indexPath.section == 0) {
//        
//        return [XHDDOnlineFunPlayDetailNumberCell rowHeight];
//    }
//    
    return [XHDDOnlineFunPlayDetailNumberCell rowHeight];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return @"选集";
    }
    
    return @"简介";
}


@end
