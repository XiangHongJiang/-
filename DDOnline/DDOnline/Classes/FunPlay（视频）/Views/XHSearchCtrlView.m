//
//  XHsearchCtrlView.m
//  Perfect_food
//
//  Created by qianfeng on 16/1/23.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "XHSearchCtrlView.h"
#import "XHUIFactory.h"
#import "KeyBoardFrame.h"
@interface XHSearchCtrlView()<UITableViewDataSource,UITableViewDelegate>
/** *  管理的底部语言输入视图 */
@property (weak, nonatomic) IBOutlet UIView *bottomSoundView;
/** *  管理的scrollView，用于添加热门搜索数据 */
@property (weak, nonatomic) IBOutlet UIScrollView *hotScorllView;
/** *  历史搜索Label */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** *  用于展示历史搜索的tableView */
@property (weak, nonatomic) IBOutlet UITableView *historySearchTableView;
/** *  清空历史按钮 */
@property (weak, nonatomic) IBOutlet UIButton *clearHistoryBtn;
@end

@implementation XHSearchCtrlView
#pragma mark - create And setup
+ (instancetype)searchCtrlView{
    
   XHSearchCtrlView *view = [[[NSBundle mainBundle] loadNibNamed:@"XHSearchCtrlView" owner:nil options:nil] firstObject];
    
    return view;
}
/**
 *  已经从XIB加载完成，进行一些设置
 */
- (void)awakeFromNib{
    //添加边线
    self.clearHistoryBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.clearHistoryBtn.layer.borderWidth = 1;
    self.clearHistoryBtn.layer.cornerRadius = 3;
    //添加键盘弹起收回监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSoundViewFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
  
}
/**
 *  设置热门搜索数组
 */
- (void)setHotSearchArray:(NSArray *)hotSearchArray{
    
    _hotSearchArray = hotSearchArray;
    
    //根据热门搜索数组创建Btn
    int count = (int)hotSearchArray.count;
    
    //间距
    CGFloat margin = 10;
    //确定Y，H
    CGFloat itemY = 0;
    CGFloat itemH = 25;
    
    //记录上一个的最大X
    CGFloat endX = 0;
    
    for (int i = 0; i < count; i ++) {
        
        //title
        NSString *title = hotSearchArray[i];
        //size
        CGSize size = [XHUIFactory calculateSizeByText:title maxSize:CGSizeMake(150, 25) font:[UIFont systemFontOfSize:17]];
        //确定W，X
        CGFloat itemW = size.width + 20;
        CGFloat itemX = margin + endX;
        
        //记录X
        endX = itemX + itemW;
        
        //create
        UIButton *button = [XHUIFactory creatBtnWithFrame:CGRectMake(itemX, itemY, itemW, itemH) title:title target:self action:@selector(hotSearchBtnClick:)];
        
        //set
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.layer.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
        button.layer.borderWidth = 0.1;
        button.layer.cornerRadius = 3;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];

        
        //add
        [self.hotScorllView addSubview:button];
        
    }
    
    //设置hotScrollView的contentSize
    self.hotScorllView.contentSize = CGSizeMake(endX + margin, 0);
    
}
/**
 *  设置历史搜索数组
 */
- (void)setHistorySearchArray:(NSArray *)historySearchArray{
    
    _historySearchArray = historySearchArray;
    
    if (_historySearchArray.count == 0) {//没有数据隐藏小控件
        
        self.titleLabel.hidden = YES;
        self.historySearchTableView.hidden = YES;
    }
    else{//有数据，设置不隐藏，并且刷新数据
        
        self.titleLabel.hidden = NO;
        self.historySearchTableView.hidden = NO;
    }
    
    [self.historySearchTableView reloadData];
    
}

#pragma mark - UITableView Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.historySearchArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //赋值
    cell.textLabel.text = self.historySearchArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

#pragma mark - response：响应
/**
 * 点击了清空历史记录
 */
- (IBAction)footClearBtn:(UIButton *)sender {
    //隐藏小控件
    self.titleLabel.hidden = YES;
    self.historySearchTableView.hidden = YES;
    
    //清空数据源
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_historySearchArray forKey:@"historySearch"];
    [ud synchronize];
    self.historySearchArray = nil;
    
    if (self.delegate) {
        
        [self.delegate searchCtrlViewDidSelectedClearHistorySearch:self];
    }

}
- (IBAction)bottomSoundBtnClick:(UIButton *)sender {
    //语音输入
    [self.delegate searchCtrlViewDidSelectedSoundInput:(XHSearchCtrlView *)self];
}
- (void)hotSearchBtnClick:(UIButton *)btn{//热门搜索
    
    [self.delegate searchCtrlView:self didSelectedHotSearch:btn.titleLabel.text];
    
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//历史搜索
    
    [self.delegate searchCtrlView:self didSelectedHistorySearch:self.historySearchArray[indexPath.row]];

}
/**
 *  改变底部frame
 */
- (void)changeSoundViewFrame:(NSNotification *)notification{
    
    NSDictionary * info = notification.userInfo;
    CGRect rect =  [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];//结束时键盘的frame位置
    self.historySearchTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
        self.bottomSoundView.y = rect.origin.y - 40 - JTopSpace;


    if (rect.origin.y < JScreenHeight) {
     self.historySearchTableView.contentInset = UIEdgeInsetsMake(0, 0, 20 + rect.size.height, 0);
    }

}
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
