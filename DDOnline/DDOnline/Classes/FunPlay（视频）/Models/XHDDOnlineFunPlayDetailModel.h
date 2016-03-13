//
//  XHDDOnlineFunPlayDetailModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/9.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FunPlayDetailResult,User_Season,Actor,Episodes,Up,Tags;
@interface XHDDOnlineFunPlayDetailModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) FunPlayDetailResult *result;

@property (nonatomic, assign) NSInteger code;

@end
@interface FunPlayDetailResult : NSObject

@property (nonatomic, strong) NSArray *related_seasons;

@property (nonatomic, copy) NSString *watchingCount;

@property (nonatomic, copy) NSString *coins;

@property (nonatomic, copy) NSString *bangumi_title;

@property (nonatomic, copy) NSString *bangumi_id;

@property (nonatomic, copy) NSString *season_title;

@property (nonatomic, copy) NSString *copyright;

@property (nonatomic, copy) NSString *play_count;

@property (nonatomic, copy) NSString *staff;

@property (nonatomic, copy) NSString *newest_ep_index;

@property (nonatomic, copy) NSString *danmaku_count;

@property (nonatomic, copy) NSString *favorites;

@property (nonatomic, copy) NSString *allow_download;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *weekday;

@property (nonatomic, strong) NSArray *episodes;

@property (nonatomic, copy) NSString *evaluate;

@property (nonatomic, copy) NSString *squareCover;

@property (nonatomic, copy) NSString *is_finish;

@property (nonatomic, copy) NSString *total_count;

@property (nonatomic, copy) NSString *newest_ep_id;

@property (nonatomic, copy) NSString *pub_time;

@property (nonatomic, strong) User_Season *user_season;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, assign) NSInteger arealimit;

@property (nonatomic, strong) NSArray *seasons;

@property (nonatomic, copy) NSString *season_id;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *actor;

@property (nonatomic, copy) NSString *brief;

@property (nonatomic, strong) NSArray *tag2s;

@property (nonatomic, copy) NSString *allow_bp;

@property (nonatomic, assign) NSInteger viewRank;

@end

@interface User_Season : NSObject

@property (nonatomic, copy) NSString *last_time;

@property (nonatomic, copy) NSString *attention;

@property (nonatomic, copy) NSString *last_ep_index;

@end

@interface Actor : NSObject

@property (nonatomic, copy) NSString *actor;

@property (nonatomic, assign) NSInteger actor_id;

@property (nonatomic, copy) NSString *role;

@end

@interface Episodes : NSObject

@property (nonatomic, copy) NSString *is_new;

@property (nonatomic, copy) NSString *is_webplay;

@property (nonatomic, copy) NSString *page;

@property (nonatomic, copy) NSString *av_id;

@property (nonatomic, strong) Up *up;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *episode_id;

@property (nonatomic, copy) NSString *coins;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *danmaku;

@property (nonatomic, copy) NSString *index;

@end

@interface Up : NSObject

@end

@interface Tags : NSObject

@property (nonatomic, copy) NSString *style_id;

@property (nonatomic, copy) NSString *tag_id;

@property (nonatomic, copy) NSString *tag_name;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger orderType;

@property (nonatomic, copy) NSString *index;

@end

