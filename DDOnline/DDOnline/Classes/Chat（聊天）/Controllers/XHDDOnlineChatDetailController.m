//
//  XHDDOnlineChatDetailController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatDetailController.h"
#import "XHDDOnlineChatMessageCell.h"
#import "EMSDKFull.h"

@interface XHDDOnlineChatDetailController ()<UITableViewDataSource,UITableViewDelegate,EMChatManagerDelegate>
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
    self.view.backgroundColor = JRandomColor;
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
#pragma mark - 发送消息处理
//获取当前对话时间字符串
- (NSString *)getCurrentSystemTimeStr{
    //获取当前时间
    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm:ss"];
    
    NSDate *date = [NSDate date];
    NSString *time = [df stringFromDate:date];
    
    return time;
}
//创建消息对象
- (XHDDOnlineChatMessageModel *)createMessageWithMessageText:(NSString *)messageText andIsFromOther:(BOOL)fromOther{

    NSString *time = [self getCurrentSystemTimeStr];
    NSDictionary *dict = @{@"text":messageText,@"time":time,@"type":@(fromOther)};
    XHDDOnlineChatMessageModel *message = [XHDDOnlineChatMessageModel messageWithDict:dict];

    return message;
}
//发送btn点击响应
- (IBAction)sendBtn:(UIButton *)sender {
    
    NSString *messageText = self.inputMessageTextView.text;
    
    XHDDOnlineChatMessageModel *message = [self createMessageWithMessageText:messageText andIsFromOther:NO];
    
    //1.向服务器发送
    [self sendMessageToFriend:message];
    //2.添加数据
    [self.messagesArray addObject:message];
    //3.刷新数据
    [self.chatContentTableView reloadData];
    //4.清空textField
    self.inputMessageTextView.text = @"";
    
    //5.设置滚动到底部
    [self setSendOrReceiveMessageTableViewScroll];
}
//设置滚动到底部
- (void)setSendOrReceiveMessageTableViewScroll{
   
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messagesArray.count - 1 inSection:0];
    [self.chatContentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}
#pragma mark - 发送消息给对方
- (void)sendMessageToFriend:(XHDDOnlineChatMessageModel *)messageText{

    //1.包装消息
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:messageText.text];
    NSString *from = [[EMClient sharedClient] currentUsername];//自己的账号
    NSString *friendID = self.navigationItem.title;
    
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:friendID from:from to:friendID body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    
    //2.发送消息:异步
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
        
        JLog(@"发送进度%d",progress);
        
    } completion:^(EMMessage *messageBody, EMError *error) {
       
        if (!error) {
            
            JLog(@"发送消息成功");
        }
        else {
            
            EMTextMessageBody *textBody = (EMTextMessageBody *)messageBody.body;
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"消息：%@ 发送失败",textBody.text]];
            //从本地删除
            [self.messagesArray removeObject:messageText];
            //刷新tableView
            [self.chatContentTableView reloadData];
        }

    }];
    
}
- (IBAction)emoticonBtn:(UIButton *)sender {
    
    JLog(@"点击了表情");
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
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 设置消息回调代理
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
#pragma mark - 解析消息回调
- (void)didReceiveCmdMessages:(NSArray *)aCmdMessages{
    for (EMMessage *message in aCmdMessages) {
        // cmd消息中的扩展属性
        NSDictionary *ext = message.ext;
        NSLog(@"cmd消息中的扩展属性是 -- %@",ext);
    }
}
// 收到消息回调@brief 接收到一条及以上非cmd消息
- (void)didReceiveMessages:(NSArray *)aMessages{
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;

                XHDDOnlineChatMessageModel *model = [self createMessageWithMessageText:txt andIsFromOther:YES];
                
                [self.messagesArray addObject:model];
                [self.chatContentTableView reloadData];
                //设置滚动到底部
                [self setSendOrReceiveMessageTableViewScroll];
            
            }
                break;
                
            default:
                break;
                
        }
    }
}


@end
