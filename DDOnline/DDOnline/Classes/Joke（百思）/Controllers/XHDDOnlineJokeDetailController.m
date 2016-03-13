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

@interface XHDDOnlineJokeDetailController ()

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
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];   
    self.view.backgroundColor = JColorBg;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

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

@end
