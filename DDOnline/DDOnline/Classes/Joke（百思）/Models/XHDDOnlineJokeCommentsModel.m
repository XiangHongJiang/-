//
//  XHDDOnlineJokeCommentsModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeCommentsModel.h"

@implementation XHDDOnlineJokeCommentsModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [Comments_Data class]};
}
@end
@implementation Comments_Data

- (void)setContent:(NSString *)content{

    _content = content;
    
    CGSize size = [XHUtils calculateSizeWithText:content maxSize:CGSizeMake(JScreenWidth - 120, JScreenHeight) font:14];
    
    self.rowHeight = size.height + 50;
}

@end


@implementation Comments_User

@end


