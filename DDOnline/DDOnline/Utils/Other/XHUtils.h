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
/**
 * 截取任意位置的image
 */
+ (UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect;

+ (UILabel *)createLabelFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font;
+ (UIButton *)createBtnFrame:(CGRect)frame imageName:(NSString *)imageName bgColor:(UIColor *)bgColor radius:(CGFloat)radius target:(id)target action:(SEL)action;
/**
 *  创建Btn的方法
 */
+ (UIButton *)creatBtnWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;

/**
 * 裁剪圆图
 */
+ (UIImage *)circleImage:(UIImage *)image;

/**
 * 获取tabBar导航CTRL
 */
+ (UINavigationController *)getCurrentTabBarNavigationCtrl;

/**
 * 压缩图片
 */
+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end

