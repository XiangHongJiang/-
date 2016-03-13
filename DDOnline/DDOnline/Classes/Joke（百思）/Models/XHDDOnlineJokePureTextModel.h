//
//  XHDDOnlineJokePureTextModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

/**段子模型*/

#import <Foundation/Foundation.h>


@class PureText_Info,PureText_List,PureText_U,PureText_Tags;
@interface XHDDOnlineJokePureTextModel :NSObject

@property (nonatomic, strong) PureText_Info *info;

@property (nonatomic, strong) NSArray *list;

@end
@interface PureText_Info : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger np;

@end

@interface PureText_List : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *up;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger down;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) PureText_U *u;

@property (nonatomic, copy) NSString *forward;

@property (nonatomic, copy) NSString *bookmark;
/**
 *   行高
 */
@property (nonatomic, assign) CGFloat rowHeight;

@end

@interface PureText_U : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSArray *header;

@property (nonatomic, assign) BOOL is_vip;

@property (nonatomic, assign) BOOL is_v;

@end

@interface PureText_Tags : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *name;

@end

