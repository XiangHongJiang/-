//
//  XHNetHelp.h
//  jianzhi
//
//  Created by qianfeng on 16/2/22.
//  Copyright © 2016年 JXH. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface XHNetHelp : AFHTTPSessionManager
/**
 *  get请求
 *
 *  @param path     url
 *  @param params   params
 *  @param complete block
 */
+ (void)getDataWithPath:(NSString *)path  andParams:(NSDictionary *)params andComplete:(void (^)(BOOL succeed,id result))complete;
/**
 *  post请求
 *
 *  @param path     url
 *  @param params   params
 *  @param complete block
 */
+ (void)postDataWithPath:(NSString *)path andParams:(NSDictionary *)params andComplete:(void (^)(BOOL succeed,id result))complete;
@end
