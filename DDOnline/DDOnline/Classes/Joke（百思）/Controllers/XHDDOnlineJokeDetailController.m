//
//  XHDDOnlineJokeDetailController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/13.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeDetailController.h"

#import "XHDDOnlineJokePureTextCell.h"
#import "XHDDOnlineJokeGifCell.h"
#import "XHDDOnlineJokeVideoCell.h"
#import "XHDDOnlineJokeDetailCommentsCell.h"
#import "XHDDOnlineJokeCommentsModel.h"

@interface XHDDOnlineJokeDetailController ()
/**
 *  评论数据模型
 */
@property (nonatomic, strong) XHDDOnlineJokeCommentsModel *commentsModel;
@end

@implementation XHDDOnlineJokeDetailController

- (void)loadView{
    [super loadView];
    //1.注册cell
    [self registCell];
}
//注册cell
- (void)registCell{

    //1.duanzi
    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineJokePureTextCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineJokePureTextCell"];
    
    //2.tu
    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineJokeGifCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineJokeGifCell"];
    
    //3.shiping
    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineJokeVideoCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineJokeVideoCell"];
    
    //4.评论
    [self.tableView registerNib:[UINib nibWithNibName:@"XHDDOnlineJokeDetailCommentsCell" bundle:nil] forCellReuseIdentifier:@"XHDDOnlineJokeDetailCommentsCell"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];   
    self.view.backgroundColor = JColorBg;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self requestComments];
}

#pragma mark - 请求评论数据
- (void)requestComments{

    [XHNetHelp getDataWithPath:[NSString stringWithFormat:kJokeComments,self.jokeBaseDetailModel.ID] andParams:nil andComplete:^(BOOL succeed, id result) {
       
        if (succeed) {
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            
            XHDDOnlineJokeCommentsModel *commentsModel = [XHDDOnlineJokeCommentsModel mj_objectWithKeyValues:dataDict];
            
            self.commentsModel = commentsModel;
            
            [self.tableView reloadData];
            
        }
        else{
        
            JLog(@"%@",result);
        }
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        
        return self.commentsModel.data.count;
    }
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        XHDDOnlineJokeDetailCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineJokeDetailCommentsCell"];
        
        cell.commentsModel = self.commentsModel.data[indexPath.row];
        
        return cell;
    }

    if (self.jokeType == JokeTypeDuanzi) {
        
        XHDDOnlineJokePureTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineJokePureTextCell"];
        cell.pureTextDetailModel = self.jokeBaseDetailModel;
        return cell;
        
    }
    else if(self.jokeType == JokeTypeGif){
    
        XHDDOnlineJokeGifCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineJokeGifCell"];
        cell.gifDetailModel = self.jokeBaseDetailModel;
        
        return cell;
    }
    else{
        
        XHDDOnlineJokeVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineJokeVideoCell"];
        cell.videoDetailModel = self.jokeBaseDetailModel;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
     
        return 80;
    }
    
    if (self.jokeType == JokeTypeDuanzi) {
        
        return [XHDDOnlineJokePureTextCell rowHeightWithPureTextDetailModel:self.jokeBaseDetailModel];
    }
    else if(self.jokeType == JokeTypeGif){
    
        return [XHDDOnlineJokeGifCell rowHeightWithgifDetailModel:self.jokeBaseDetailModel];
    }
    else{
    
        return [XHDDOnlineJokeVideoCell rowHeightWithvideoDetailModel:self.jokeBaseDetailModel];
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc]initWithString:@"最新评论"];
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
        [mAttr setAttributes:attributes range:NSMakeRange(0, mAttr.length)];
        
        UILabel *label = [[UILabel alloc]init];
        label.size = CGSizeMake(JScreenWidth, 30);
        label.attributedText = mAttr;
        label.textAlignment = NSTextAlignmentCenter;
        
        return label;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        
        return 30;
    }
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
