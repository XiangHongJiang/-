//
//  XHDDOnlineJokeBaseModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/13.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeBaseModel.h"

@implementation XHDDOnlineJokeBaseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [JokeBase_List class]};
}
@end
@implementation JokeBase_Info

@end


@implementation JokeBase_List

+ (NSDictionary *)objectClassInArray{
    return @{@"tags" : [JokeBase_Tags class]};
}

@end


@implementation JokeBase_U

@end


@implementation JokeBase_Tags

@end


//video
@implementation JokeVideo_Video

@end
//gif
@implementation JokeGF_Gif


@end
//gif
@implementation JokeGF_Image

@end

