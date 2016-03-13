//
//  NSObject+Extension.h
//  SinaWeiBo-Foundation
//
//  Created by qianfeng on 16/1/27.
//  Copyright (c) 2016年 JXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
/** *  KVC */
+(id)objectWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;
/** *  AOP */
+(void)exchangeOldMethod:(SEL)oldMethod withNewMethod:(SEL)newMethod;
@end
