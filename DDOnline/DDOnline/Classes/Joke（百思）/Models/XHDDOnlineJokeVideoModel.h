//
//  XHDDOnlineJokeVideoModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>


@class JokeVideo_Info,JokeVideo_List,JokeVideo_U,JokeVideo_Video,JokeVideo_Tags;
@interface XHDDOnlineJokeVideoModel : NSObject

@property (nonatomic, strong) JokeVideo_Info *info;

@property (nonatomic, strong) NSArray *list;

@end
@interface JokeVideo_Info : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger np;

@end

@interface JokeVideo_List : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *up;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger down;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) JokeVideo_U *u;

@property (nonatomic, copy) NSString *forward;

@property (nonatomic, copy) NSString *bookmark;

@property (nonatomic, strong) JokeVideo_Video *video;

@end

@interface JokeVideo_U : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSArray *header;

@property (nonatomic, assign) BOOL is_vip;

@property (nonatomic, assign) BOOL is_v;

@end

@interface JokeVideo_Video : NSObject

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, strong) NSArray *thumbnail;

@property (nonatomic, strong) NSArray *download;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger playfcount;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, strong) NSArray *video;

@property (nonatomic, assign) NSInteger playcount;

@end

@interface JokeVideo_Tags : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@end

