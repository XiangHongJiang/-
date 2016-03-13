//
//  NSObject+Extension.m
//  SinaWeiBo-Foundation
//
//  Created by qianfeng on 16/1/27.
//  Copyright (c) 2016年 JXH. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

#pragma mark - KVC
+(id)objectWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}
-(id)initWithDict:(NSDictionary *)dict{
    
    if (self = [self init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

#pragma mark - AOP
+(void)exchangeOldMethod:(SEL)oldMethod withNewMethod:(SEL)newMethod{
    
    Method oldM = class_getInstanceMethod([self class], oldMethod);
    
    Method newM = class_getInstanceMethod([self class], newMethod);
    
    method_exchangeImplementations(oldM, newM);
    
}
@end
