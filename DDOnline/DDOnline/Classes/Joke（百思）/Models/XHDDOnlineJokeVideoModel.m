//
//  XHDDOnlineJokeVideoModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeVideoModel.h"

@implementation XHDDOnlineJokeVideoModel




+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [JokeVideo_List class]};
}
@end


@implementation JokeVideo_Info

@end


@implementation JokeVideo_List

+ (NSDictionary *)objectClassInArray{
    return @{@"tags" : [JokeVideo_Tags class]};
}

@end


@implementation JokeVideo_U

@end


@implementation JokeVideo_Video

@end


@implementation JokeVideo_Tags

@end


