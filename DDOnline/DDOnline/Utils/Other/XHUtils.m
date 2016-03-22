//
//  XHUtils.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHUtils.h"
#import "XHDDOnlineMainController.h"
#import "XHDDOnlineRootTabBarController.h"
#import "RESideMenu.h"

@implementation XHUtils
//
+ (CGSize)calculateSizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(CGFloat)font{

    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return size;
}
//字符串转化成日期
+ (NSString *)timeStringFromDateString:(NSString *)dateString
{
    //字符串转化成日期
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //2016-01-11 13:09:27
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *pubDate = [df dateFromString:dateString];
    
    //计算时间差
    //日历对象
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    /*
     计算两个日期之间的时间差
     第一个参数:时间差关注的参数(年月日时分秒)
     第二个参数:开始时间
     第三个参数:结束时间
     第三个参数:其他参数(0)
     */
    unsigned int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dc = [calendar components:unit fromDate:pubDate toDate:[NSDate date] options:0];
    //日期字符串
    NSString *dateStr = @"";
    if ([dc year] > 0) {
        dateStr = [NSString stringWithFormat:@"%ld年前",(long)[dc year]];
    }else if ([dc month] > 0) {
        dateStr = [NSString stringWithFormat:@"%ld月前",(long)[dc month]];
    }else if ([dc day] > 0){
        dateStr = [NSString stringWithFormat:@"%ld天前",(long)[dc day]];
    }else if ([dc hour] > 0) {
        dateStr = [NSString stringWithFormat:@"%ld小时前",(long)[dc hour]];
    }else if ([dc minute] > 0){
        dateStr = [NSString stringWithFormat:@"%ld分前",(long)[dc minute]];
    }else if ([dc second] > 1) {
        dateStr = [NSString stringWithFormat:@"%ld秒前",(long)[dc second]];
    }else{
        dateStr = @"刚刚";
    }
    
    return dateStr;
}
//clipImage：截取image
+(UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect{

    CGImageRef cgImage = image.CGImage;

    cgImage = CGImageCreateWithImageInRect(cgImage,rect);

    image = [UIImage imageWithCGImage:cgImage];

    return image;
}
// Label
+ (UILabel *)createLabelFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    return label;
}
+ (UIButton *)createBtnFrame:(CGRect)frame imageName:(NSString *)imageName bgColor:(UIColor *)bgColor radius:(CGFloat)radius target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    //设置圆角
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    //点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}
+ (UIButton *)creatBtnWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action{
    
    //创建btn
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/**
 * 画圆
 */
+ (UIImage *)circleImage:(UIImage *)image{
    //开启image绘制
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //做一个圆
    CGRect circleRect = (CGRect){
        (CGPoint){0,0},
        image.size
    };
    //画圆
    CGContextAddEllipseInRect(ctx, circleRect);
    //设置裁剪图片
    CGContextClip(ctx);
    //画上iamge
    [image drawInRect:circleRect];
    
    //获取画后的圆的image
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束image绘制
    UIGraphicsEndImageContext();
    
    return circleImage;
    
}
//获取当前导航控制器
+ (UINavigationController *)getCurrentTabBarNavigationCtrl{
   
    RESideMenu *sideMenu =(RESideMenu *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    XHDDOnlineRootTabBarController *rootTbc = sideMenu.contentViewController.childViewControllers[0];
    UINavigationController *nav = rootTbc.selectedViewController;

    return nav;
}
//压缩图片
+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage =UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
@end
