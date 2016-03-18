//
//  XHDDOnlineChatMessageModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatMessageModel.h"

@implementation XHDDOnlineChatMessageModel
+ (id)messageWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        [self sureFrameAndRowHeight];
    }
    
    return self;
}

- (void)sureFrameAndRowHeight{
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //1.timeLabel
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 20;
    
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat margin = 10;
    //2.headerImageView
    CGFloat headerX = margin;
    CGFloat headerY = CGRectGetMaxY(_timeFrame);
    CGFloat headerW = 50;
    CGFloat headerH = 50;
    if (self.type == MessageTypeMe) {
        
        headerX = screenW - margin - headerW;
    }
    
    _headerFrame = CGRectMake(headerX, headerY, headerW, headerH);
    
    //3.contentButton
    CGSize size = CGSizeMake(JScreenWidth - headerW * 2 - 20, CGFLOAT_MAX);
    size = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    CGFloat contentX = CGRectGetMaxX(_headerFrame);
    CGFloat contentY = CGRectGetMaxY(_timeFrame);
    CGFloat contentW = size.width + 40;
    CGFloat contentH = size.height + 40;
    
    if (self.type == MessageTypeMe) {
        
        contentX = screenW - margin - headerW - contentW;
    }
    
    _contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    
    //4. rowHeight
    
    _rowHeight = MAX(CGRectGetMaxY(_headerFrame), CGRectGetMaxY(_contentFrame));
    
    
}@end
