//
//  XHDDOnlineNotReadMessageCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineNotReadMessageCell.h"

@interface XHDDOnlineNotReadMessageCell()
@property (weak, nonatomic) IBOutlet UILabel *chatFriendName;
@property (weak, nonatomic) IBOutlet UILabel *latestMessage;
@end

@implementation XHDDOnlineNotReadMessageCell

+ (instancetype)notReadMessageCellWithTableView:(UITableView *)tableView{

    XHDDOnlineNotReadMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XHDDOnlineNotReadMessageCell"];
    
    if (cell == nil) {
        cell = [[XHDDOnlineNotReadMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"XHDDOnlineNotReadMessageCell"];
    }
    return cell;
}

- (void)setLatestModel:(XHDDOnlineLastestMessageModel *)latestModel{
    _latestModel = latestModel;
    
    NSArray *nameArray = [latestModel.name componentsSeparatedByString:@"/"];
    
    self.chatFriendName.text = nameArray.lastObject;
    
    NSString *message = [NSString stringWithFormat:@"%@:%@",nameArray.lastObject,latestModel.lastMessage];
    
    if (!latestModel.fromOther) {
        message = [NSString stringWithFormat:@"%@(我):  %@",nameArray.firstObject,latestModel.lastMessage];
    }    
    self.latestMessage.text = message;
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
