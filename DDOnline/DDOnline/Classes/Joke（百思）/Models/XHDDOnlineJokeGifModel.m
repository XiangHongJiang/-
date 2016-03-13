//
//  XHDDOnlineJokeGifModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeGifModel.h"

@implementation XHDDOnlineJokeGifModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [JokeGF_List class]};
}
@end
@implementation JokeGF_Info

@end


@implementation JokeGF_List

+ (NSDictionary *)objectClassInArray{
    return @{@"tags" : [JokeGF_Tags class]};
}

@end

@implementation JokeGF_Gif


@end


@implementation JokeGF_Image

@end


@implementation JokeGF_U

@end


@implementation JokeGF_Tags

@end


