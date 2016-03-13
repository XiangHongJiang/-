//
//  XHUtils.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHUtils : NSObject

+ (NSString *)timeStringFromDateString:(NSString *)dateString;

+ (CGSize)calculateSizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(CGFloat)font;
@end
