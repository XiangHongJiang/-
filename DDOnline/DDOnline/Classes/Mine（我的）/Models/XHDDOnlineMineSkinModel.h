//
//  XHDDOnlineMineSkinModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHDDOnlineMineSkinModel : NSObject

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *teamId;
+ (instancetype)skinWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
