//
//  XHDDOnlineCategoryDetailModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/10.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CategoryDetailResult,CD_New_Ep,cd_Up,CD_User_Season,CDTags;
@interface XHDDOnlineCategoryDetailModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *pages;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) NSArray *result;


@end

@interface CategoryDetailResult : NSObject

@property (nonatomic, strong) NSArray *related_seasons;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *watchingCount;

@property (nonatomic, copy) NSString *bangumi_title;

@property (nonatomic, copy) NSString *bangumi_id;

@property (nonatomic, copy) NSString *season_title;

@property (nonatomic, copy) NSString *spid;

@property (nonatomic, copy) NSString *copyright;

@property (nonatomic, copy) NSString *play_count;

@property (nonatomic, copy) NSString *staff;

@property (nonatomic, copy) NSString *newest_ep_index;

@property (nonatomic, copy) NSString *danmaku_count;

@property (nonatomic, copy) NSString *favorites;

@property (nonatomic, copy) NSString *allow_download;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *ewn_cover;

@property (nonatomic, copy) NSString *weekday;

@property (nonatomic, strong) NSArray *episodes;

@property (nonatomic, copy) NSString *evaluate;

@property (nonatomic, copy) NSString *squareCover;

@property (nonatomic, copy) NSString *is_finish;

@property (nonatomic, copy) NSString *total_count;

@property (nonatomic, copy) NSString *newest_ep_id;

@property (nonatomic, copy) NSString *pub_time;

@property (nonatomic, copy) NSString *last_time;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) CD_User_Season *user_season;

@property (nonatomic, strong) NSArray *seasons;

@property (nonatomic, copy) NSString *season_id;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *actor;

@property (nonatomic, copy) NSString *brief;

@property (nonatomic, strong) CD_New_Ep *ewn_ep;

@property (nonatomic, copy) NSString *allow_bp;

@property (nonatomic, strong) NSArray *tag2s;

@end

@interface CD_New_Ep : NSObject

@property (nonatomic, copy) NSString *page;

@property (nonatomic, strong) cd_Up *up;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *av_id;

@property (nonatomic, copy) NSString *episode_id;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *danmaku;

@property (nonatomic, copy) NSString *index_title;

@property (nonatomic, copy) NSString *index;

@end

@interface cd_Up : NSObject

@end

@interface CD_User_Season : NSObject

@property (nonatomic, copy) NSString *last_time;

@property (nonatomic, copy) NSString *attention;

@property (nonatomic, copy) NSString *last_ep_index;

@end

@interface CDTags : NSObject

@property (nonatomic, copy) NSString *style_id;

@property (nonatomic, copy) NSString *tag_id;

@property (nonatomic, copy) NSString *tag_name;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger orderType;

@property (nonatomic, copy) NSString *index;

@end

