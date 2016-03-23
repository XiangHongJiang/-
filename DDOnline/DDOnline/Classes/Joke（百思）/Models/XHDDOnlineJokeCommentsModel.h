//
//  XHDDOnlineJokeCommentsModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/23.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comments_Data,Comments_User;
@interface XHDDOnlineJokeCommentsModel : NSObject

@property (nonatomic, strong) NSArray<Comments_Data *> *data;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *total;

@property (nonatomic, strong) NSArray *hot;

@end
@interface Comments_Data : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *precid;

@property (nonatomic, strong) Comments_User *user;

@property (nonatomic, copy) NSString *data_id;

@property (nonatomic, strong) NSArray *precmt;

@property (nonatomic, copy) NSString *voicetime;

@property (nonatomic, copy) NSString *ctime;

@property (nonatomic, copy) NSString *like_count;

@property (nonatomic, copy) NSString *voiceuri;

@property (nonatomic, copy) NSString *preuid;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *content;
/**
 *
 */
@property (nonatomic, assign) CGFloat rowHeight;

@end

@interface Comments_User : NSObject

@property (nonatomic, copy) NSString *qq_uid;

@property (nonatomic, assign) BOOL is_vip;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *weibo_uid;

@property (nonatomic, copy) NSString *personal_page;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *qzone_uid;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *profile_image;

@end

