//
//  XHUtils.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHUtils.h"

@implementation XHUtils
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

+(UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect{

    CGImageRef cgImage = image.CGImage;

    cgImage = CGImageCreateWithImageInRect(cgImage,rect);

    image = [UIImage imageWithCGImage:cgImage];

    return image;
}
@end
