//
//  XHNetHelp.m
//  jianzhi
//
//  Created by qianfeng on 16/2/22.
//  Copyright © 2016年 JXH. All rights reserved.
//

#import "XHNetHelp.h"

static XHNetHelp *manager = nil;

@implementation XHNetHelp

//单例模式
+ (instancetype)sharedManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // AFHTTPSessionManager 单例对象，可以在程序短时间内发起多个请求时，降低系统开销
        manager = [[super allocWithZone:NULL] initWithBaseURL:[NSURL URLWithString:@""]];// 这里使用 BaseUrl ，是让 AFNetworking 减少每次请求服务器时候，提升查找目标服务器地址的速度，而且这里建议直接使用 ip 地址。
        // 设置网络请求 SSL 功能，使用（HTTPS）时开启
        //		_shareManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 设置请求内容的序列化方式
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 设置网络超时的时间，10秒。
        manager.requestSerializer.timeoutInterval = 10;
        // 设置服务器返回数据的序列化方式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置可接受的服务器返回数据的格式
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return manager;
    
}
/** *  get */
+ (void)getDataWithPath:(NSString *)path andParams:(NSDictionary *)params andComplete:(void (^)(BOOL, id))complete{
    
    
//    [[self sharedManager] GET:path parameters:params success:^(AFHTTPRequestOperation * operation, id  responseObject) {
//        
//        complete(YES,responseObject);
//        
//    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
//        
//        complete(NO,error.localizedDescription);
//    }];
    
    [[self sharedManager] GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(YES,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        complete(NO,error.localizedDescription);
    }];
    
//    [[self sharedManager] GET:path parameters:params progress:^(NSProgress *downloadProgress) {
//        //下载的进度，如果需要可实现
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        // 请求成功，block 返回服务器返回的数据。
//        // 这里是因为服务器返回数据不一定为字符串或者是 json 数据，所以不做其他处理，直接返回，如果是其他需求，也可以再继续进行其他处理
//
//        complete(YES,responseObject);
//    } failure:^(NSURLSessionDataTask  *task, NSError *error) {
//        // 网络请求失败，返回失败原因
//        complete(NO,error.localizedDescription);
//    }];
}
/** *  post */
+ (void)postDataWithPath:(NSString *)path andParams:(NSDictionary *)params andComplete:(void (^)(BOOL, id))complete{
    
//    [[self sharedManager] POST:path parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//         complete(YES,responseObject);
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        complete(NO,error.localizedDescription);
//    }];
    
//    [[self sharedManager] POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        complete(YES,responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//       
//        complete(NO,error.localizedDescription);
//    }];

    [[self sharedManager] POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        complete(YES,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         complete(NO,error.localizedDescription);
    }];
}

@end
