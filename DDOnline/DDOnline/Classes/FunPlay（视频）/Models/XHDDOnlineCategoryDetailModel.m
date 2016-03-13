//
//  XHDDOnlineCategoryDetailModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/10.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineCategoryDetailModel.h"

@implementation XHDDOnlineCategoryDetailModel


+ (NSDictionary *)objectClassInArray{
    return @{@"result" : [CategoryDetailResult class]};
}
@end@implementation CategoryDetailResult

+ (NSDictionary *)objectClassInArray{
    return @{@"tags" : [CDTags class]};
}

@end


@implementation CD_New_Ep

@end


@implementation cd_Up

@end


@implementation CD_User_Season

@end


@implementation CDTags

@end


