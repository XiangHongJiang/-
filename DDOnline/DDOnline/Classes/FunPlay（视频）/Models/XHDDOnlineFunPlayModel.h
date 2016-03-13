//
//  XHDDOnlineFunPlayModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseFunPlayModel,LatestupdateModel,LatestList,RecommendCategoryModel,CategoriesModel,Different,List,DeepList;
@interface XHDDOnlineFunPlayModel : NSObject

@property (nonatomic, strong) BaseFunPlayModel *result;

@end
@interface BaseFunPlayModel : NSObject

@property (nonatomic, strong) LatestupdateModel *latestUpdate;

@property (nonatomic, strong) NSArray *recommendCategory;

@property (nonatomic, strong) NSArray *categories;

@end

@interface LatestupdateModel : NSObject

@property (nonatomic, copy) NSString *updateCount;

@property (nonatomic, strong) NSArray *list;

@end

@interface LatestList : NSObject

@property (nonatomic, copy) NSString *newest_ep_id;

@property (nonatomic, copy) NSString *season_id;

@property (nonatomic, copy) NSString *watchingCount;

@property (nonatomic, copy) NSString *bangumi_title;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *newest_ep_index;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *last_time;

@property (nonatomic, copy) NSString *total_count;

@end

@interface RecommendCategoryModel : NSObject

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *tag_name;

@property (nonatomic, copy) NSString *tag_id;

@end

@interface CategoriesModel : NSObject

@property (nonatomic, strong) Different *category;

@property (nonatomic, strong) List *list;

@end

@interface Different : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *tag_name;

@property (nonatomic, assign) NSInteger orderType;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *tag_id;

@end

@interface List : NSObject

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *pages;

@property (nonatomic, strong) NSArray *list;

@end

@interface DeepList : NSObject

@property (nonatomic, copy) NSString *is_finish;

@property (nonatomic, copy) NSString *season_id;

@property (nonatomic, copy) NSString *bangumi_id;

@property (nonatomic, copy) NSString *spid;

@property (nonatomic, copy) NSString *bangumi_title;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *newest_ep_index;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *season_title;

@property (nonatomic, copy) NSString *total_count;

@end

