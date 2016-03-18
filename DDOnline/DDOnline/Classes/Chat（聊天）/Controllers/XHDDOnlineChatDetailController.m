//
//  XHDDOnlineChatDetailController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatDetailController.h"
#import "XHDDOnlineChatMessageCell.h"

@interface XHDDOnlineChatDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewLayoutBottom;

@property (weak, nonatomic) IBOutlet UITableView *chatContentTableView;
@property (weak, nonatomic) IBOutlet UITextView *inputMessageTextView;
@property (weak, nonatomic) IBOutlet UIButton *soundInputView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)sendBtn:(UIButton *)sender;
- (IBAction)emoticonBtn:(UIButton *)sender;
/**
 *  messageArray
 */
@property (nonatomic, strong) NSMutableArray *messagesArray;

@end

@implementation XHDDOnlineChatDetailController

- (NSMutableArray *)messagesArray{

    if (_messagesArray == nil) {
        
        self.messagesArray = [NSMutableArray array];
    }
    
    return _messagesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatContentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    //1.添加键盘监听
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //2.添加点击监听
    [self.chatContentTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignInput)]];
    

}

- (void)resignInput{

    if (self.inputMessageTextView.isFirstResponder) {
        
        [self.view endEditing:YES];
    }
}

- (IBAction)sendBtn:(UIButton *)sender {
    
    //获取当前时间
    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm:ss"];
    
    NSDate *date = [NSDate date];
    NSString *time = [df stringFromDate:date];
    
    //1.创建数据
    NSDictionary *dict = @{@"text":self.inputMessageTextView.text,@"time":time,@"type":@(0)};
    
    
    XHDDOnlineChatMessageModel *message = [XHDDOnlineChatMessageModel messageWithDict:dict];
    
    //2.添加数据
    [self.messagesArray addObject:message];
    
    //3.刷新数据
    [self.chatContentTableView reloadData];
    
    //4.清空textField
    self.inputMessageTextView.text = @"";
    
    //5.设置滚动到底部
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messagesArray.count - 1 inSection:0];
    
    JLog(@"%@",indexPath);
    
    
    [self.chatContentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}


- (IBAction)emoticonBtn:(UIButton *)sender {
    
}
#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.messagesArray[indexPath.row] rowHeight];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XHDDOnlineChatMessageCell *cell = [XHDDOnlineChatMessageCell messageCellWithTableView:tableView];
    
    cell.message = self.messagesArray[indexPath.row];
    
    return cell;
    
}
#pragma mark - 输入滚动相关
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - 键盘监听frame改变
- (void)keyboardChange:(NSNotification *)notification{
    
    NSDictionary *infoDict = notification.userInfo;
    //取出结束时的键盘坐标
    CGRect keyboardRect = [infoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //计算移动的距离
    CGFloat distanceY = JScreenHeight - keyboardRect.origin.y;
    
    self.bottomViewLayoutBottom.constant = distanceY;
    //更改约束
    [UIView animateWithDuration:0.25 animations:^{
       
        [self.bottomView layoutIfNeeded];
        [self.chatContentTableView layoutIfNeeded];
       
    }];
    
    
}

@end
