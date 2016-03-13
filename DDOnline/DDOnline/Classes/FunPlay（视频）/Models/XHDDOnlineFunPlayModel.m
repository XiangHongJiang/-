//
//  XHDDOnlineFunPlayModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFunPlayModel.h"

@implementation XHDDOnlineFunPlayModel

@end
@implementation BaseFunPlayModel

+ (NSDictionary *)objectClassInArray{
    return @{@"recommendCategory" : [RecommendCategoryModel class], @"categories" : [CategoriesModel class]};
}

@end


@implementation LatestupdateModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [LatestList class]};
}

@end


@implementation LatestList

@end


@implementation RecommendCategoryModel

@end


@implementation CategoriesModel

@end


@implementation Different

@end


@implementation List

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [DeepList class]};
}

@end

@implementation DeepList

@end



