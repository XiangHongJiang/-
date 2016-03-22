//
//  XHDDOnlineLastestMessageModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/22.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHDDOnlineLastestMessageModel : NSObject
/**
 *  name
 */
@property (nonatomic, copy) NSString *name;
/**
 *  lastMessage
 */
@property (nonatomic, copy) NSString *lastMessage;
/**
 *  fromOther
 */
@property (nonatomic, assign) BOOL fromOther;
/**
 *  time
 */
@property (nonatomic, copy) NSString *time;

//+ (instancetype)lasetstMessagModelWithDict:(NSDictionary *)dict;
@end
