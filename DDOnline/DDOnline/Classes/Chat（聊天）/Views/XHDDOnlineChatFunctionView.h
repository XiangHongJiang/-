//
//  XHDDOnlineChatFunctionView.h
//  DDOnline
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  ChatFunctionViewFunctionType{

    ChatFunctionViewFunctionTypeEditing,//编辑状态
    ChatFunctionViewFunctionTypeAddFriends,//添加好友
    ChatFunctionViewFunctionTypeScan//扫一扫
    
}ChatFunctionViewFunctionType;

@interface XHDDOnlineChatFunctionView : UIView
/**
 *  功能回调Block
 */
@property (nonatomic, copy) void(^functionBlock)(ChatFunctionViewFunctionType);

+ (instancetype)chatFunctionView;

@end
