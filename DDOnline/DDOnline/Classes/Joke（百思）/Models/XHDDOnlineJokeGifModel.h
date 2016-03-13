//
//  XHDDOnlineJokeGifModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JokeGF_Info,JokeGF_List,JokeGF_Image,JokeGF_U,JokeGF_Tags,JokeGF_Gif;
@interface XHDDOnlineJokeGifModel : NSObject

@property (nonatomic, strong) JokeGF_Info *info;

@property (nonatomic, strong) NSArray *list;

@end
@interface JokeGF_Info : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger np;

@end

@interface JokeGF_List : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *up;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) JokeGF_Image *image;
/**
 *  gif
 */
@property (nonatomic, strong) JokeGF_Gif *gif;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger down;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) JokeGF_U *u;

@property (nonatomic, copy) NSString *forward;

@property (nonatomic, copy) NSString *bookmark;

@end

@interface JokeGF_Gif : NSObject

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, strong) NSArray *download_url;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, strong) NSArray *gif_thumbnail;

@end

@interface JokeGF_Image : NSObject

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, strong) NSArray *medium;

@property (nonatomic, strong) NSArray *small;

@property (nonatomic, strong) NSArray *big;

@property (nonatomic, strong) NSArray *download_url;

@property (nonatomic, assign) NSInteger height;

@end

@interface JokeGF_U : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSArray *header;

@property (nonatomic, assign) BOOL is_vip;

@property (nonatomic, assign) BOOL is_v;

@end

@interface JokeGF_Tags : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@end

