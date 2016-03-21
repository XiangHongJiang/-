//
//  XHDDOnlineMineSkinModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineMineSkinModel.h"

@implementation XHDDOnlineMineSkinModel

+ (instancetype)skinWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.teamId = dict[@"teamId"];
        self.address = dict[@"address"];
    }
    return self;
}
@end
