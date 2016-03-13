//
//  XHDDOnlineJokePureTextModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokePureTextModel.h"

@implementation XHDDOnlineJokePureTextModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [PureText_List class]};
}
@end
@implementation PureText_Info

@end


@implementation PureText_List

+ (NSDictionary *)objectClassInArray{
    return @{@"tags" : [PureText_Tags class]};
}

@end


@implementation PureText_U

@end


@implementation PureText_Tags

@end


