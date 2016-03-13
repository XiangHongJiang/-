//
//  XHUIFactory.h
//  Perfect_food
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XHUIFactory : NSObject
/**
 *  创建Btn的方法
 */
+ (UIButton *)creatBtnWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;
/**
 * 计算size的方法
 */
+ (CGSize)calculateSizeByText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;
/**
 *  XMLTool
 */
//+ (NSDictionary *)dictWithXMLElement:(ONOXMLElement *)element;
@end
