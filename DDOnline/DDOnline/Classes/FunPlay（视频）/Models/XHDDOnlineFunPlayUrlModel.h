//
//  XHDDOnlineFunPlayUrlModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/10.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayDurl;
@interface XHDDOnlineFunPlayUrlModel : NSObject

@property (nonatomic, copy) NSString *from;

@property (nonatomic, copy) NSString *result;

@property (nonatomic, copy) NSString *format;

@property (nonatomic, assign) NSInteger timelength;

@property (nonatomic, strong) NSArray *accept_quality;

@property (nonatomic, copy) NSString *seek_param;

@property (nonatomic, copy) NSString *accept_format;

@property (nonatomic, copy) NSString *seek_type;

@property (nonatomic, strong) NSArray *durl;

@end

@interface PlayDurl : NSObject

@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) NSArray *backup_url;

@property (nonatomic, assign) NSInteger order;

@property (nonatomic, assign) NSInteger length;

@property (nonatomic, copy) NSString *url;

@end

