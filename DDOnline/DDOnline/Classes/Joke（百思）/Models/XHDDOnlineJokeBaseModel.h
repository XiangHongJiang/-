//
//  XHDDOnlineJokeBaseModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/13.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JokeBase_Info,JokeBase_List,JokeBase_U,JokeBase_Tags,JokeGF_Image,JokeGF_Gif,JokeVideo_Video;
@interface XHDDOnlineJokeBaseModel : NSObject

@property (nonatomic, strong) JokeBase_Info *info;

@property (nonatomic, strong) NSArray *list;

@end
@interface JokeBase_Info : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger np;

@end

@interface JokeBase_List : NSObject
/**
 * video
 */
@property (nonatomic, strong) JokeVideo_Video *video;
/**
 * image
 */
@property (nonatomic, strong) JokeGF_Image *image;
/**
 *  gif
 */
@property (nonatomic, strong) JokeGF_Gif *gif;
/**
 *  textLabelHeight
 */
@property (nonatomic, assign) CGFloat textHeight;
/**
 *  gifImageHeight
 */
@property (nonatomic, assign) CGFloat gifImageHeight;
/**
 *  videoImageHeight
 */
@property (nonatomic, assign) CGFloat videoImageHeight;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *up;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger down;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) JokeBase_U *u;

@property (nonatomic, copy) NSString *forward;

@property (nonatomic, copy) NSString *bookmark;

@end

@interface JokeBase_U : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSArray *header;

@property (nonatomic, assign) BOOL is_vip;

@property (nonatomic, assign) BOOL is_v;

@end

@interface JokeBase_Tags : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@end
/**
 *  Gif
 */
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
/**
 *  Video
 */
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
