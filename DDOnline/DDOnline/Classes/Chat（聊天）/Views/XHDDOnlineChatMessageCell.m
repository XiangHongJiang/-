//
//  XHDDOnlineChatMessageCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatMessageCell.h"

@interface XHDDOnlineChatMessageCell()

@property (nonatomic, weak) UILabel * timeLabel;

@property (nonatomic, weak) UIImageView * headerImageView;

@property (nonatomic, weak) UIButton *contentButton;

@end

@implementation XHDDOnlineChatMessageCell

+ (id)messageCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    
    XHDDOnlineChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    
    if (cell == nil) {
        
        cell = [[XHDDOnlineChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //1.timeLabel
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        
        //2.headerImageView
        UIImageView *headerImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:headerImageView];
        self.headerImageView = headerImageView;
        
        //3.contentButton
        UIButton *contentButton = [[UIButton alloc] init];
        [self.contentView addSubview:contentButton];
        self.contentButton = contentButton;
        
        [contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        contentButton.titleLabel.numberOfLines = 0;
        contentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        contentButton.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        
        
    }
    return self;
}

- (void)setMessage:(XHDDOnlineChatMessageModel *)message{
    
    _message = message;
    //1.更新数据；
    self.timeLabel.text = message.time;
    
    
    
    self.headerImageView.image = [XHUtils circleImage:[UIImage imageNamed:@"otherHeaderImage"]];
    
    if (message.type == MessageTypeMe) {
        
        UIImage *image = [UIImage imageNamed:@"chat_send_nor"];
        
        image = [self changeImageWithImage:image];
        
        [self.contentButton setBackgroundImage:image forState:UIControlStateNormal];
        
        self.headerImageView.image = [XHUtils circleImage:[UIImage imageNamed:@"selfHeaderImage"]];
        
    }
    else{
        
        UIImage *image = [UIImage imageNamed:@"chat_recive_press_pic"];
        
        image = [self changeImageWithImage:image];
        
        [self.contentButton setBackgroundImage:image forState:UIControlStateNormal];
        
    }
    
    [self.contentButton setTitle:message.text forState:UIControlStateNormal];
    //2.更新frame；
    self.timeLabel.frame = message.timeFrame;
    self.headerImageView.frame = message.headerFrame;
    self.contentButton.frame = message.contentFrame;
}

- (UIImage *)changeImageWithImage:(UIImage *)image{
    
    CGFloat imageX = image.size.width * 0.5;
    CGFloat imageY = image.size.height * 0.5;
    CGFloat imageW = imageX;
    CGFloat imageH = imageY;
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageX, imageY, imageW, imageH)];
    
    return image;
}

@end
