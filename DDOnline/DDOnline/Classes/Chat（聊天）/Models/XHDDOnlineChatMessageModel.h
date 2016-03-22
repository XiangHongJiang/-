//
//  XHDDOnlineChatMessageModel.h
//  DDOnline
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
typedef enum MessageType{
    
    MessageTypeMe,
    MessageTypeOther
    
}MessageType;

@interface XHDDOnlineChatMessageModel : NSObject
#pragma mark - 所有属性
@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) MessageType type;
/** *  消息所有者 */
@property (nonatomic, copy) NSString *name;

#pragma mark - 确定宽高
@property (nonatomic, assign) CGRect timeFrame;

@property (nonatomic, assign) CGRect headerFrame;

@property (nonatomic, assign) CGRect contentFrame;

@property (nonatomic, assign) CGFloat rowHeight;

+ (id)messageWithDict:(NSDictionary *)dict;

- (id)initWithDict:(NSDictionary *)dict;
@end
