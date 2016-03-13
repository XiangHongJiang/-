//
//  XHSoundInputView.h
//  Perfect_food
//
//  Created by qianfeng on 16/1/24.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHSoundInputView : UIView
/**
 *  识别的语音
 */
@property (nonatomic, copy, readonly) NSString *soundString;
/**
 *  检测语音的block
 */
@property (nonatomic, copy) void(^detectSoundSucceedBlock)(NSString *soundString);

//快速创建
+ (instancetype)soundInputView;
@end
