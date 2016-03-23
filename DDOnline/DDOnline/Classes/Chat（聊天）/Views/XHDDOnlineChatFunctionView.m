//
//  XHDDOnlineChatFunctionView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatFunctionView.h"

@interface XHDDOnlineChatFunctionView()<UITableViewDataSource, UITableViewDelegate>
- (IBAction)tapAction:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UITableView *functionTableView;
/**
 *  功能列表名
 */
@property (nonatomic, copy) NSArray *functionNameArray;
/**
 *  图片数组
 */
@property (nonatomic, copy) NSArray *imageNameArray;

@end

@implementation XHDDOnlineChatFunctionView

- (NSArray *)functionNameArray{

    if (_functionNameArray == nil) {
        
        _functionNameArray = @[@"删除好友",@"添加好友"/*,@"扫一扫"*/];
        
        self.imageNameArray = @[@"sec_aio_entery",@"right_menu_addFri",@"right_menu_QR"];
    }
    
    return _functionNameArray;
}

+ (instancetype)chatFunctionView{

    XHDDOnlineChatFunctionView *chatFunctionView = [[NSBundle mainBundle] loadNibNamed:@"XHDDOnlineChatFunctionView" owner:nil options:nil].firstObject;
    
    chatFunctionView.frame = CGRectMake(0, 0, JScreenWidth, JScreenHeight);
    
    return chatFunctionView;

}
- (void)awakeFromNib{

    //设置子视图
    self.functionTableView.layer.cornerRadius = 4;
    self.functionTableView.layer.masksToBounds = YES;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.functionNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    
    cell.textLabel.text = self.functionNameArray[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    
    return cell;
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    
    [self removeFromSuperview];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self removeFromSuperview];
#warning 这里可能会有问题。。。对象销毁。回调失败
    //进入相应的功能
    self.functionBlock((ChatFunctionViewFunctionType)indexPath.row);
    
}

@end
