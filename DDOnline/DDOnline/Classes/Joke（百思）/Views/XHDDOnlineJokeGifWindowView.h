//
//  XHDDOnlineJokeGifWindowView.h
//  DDOnline
//
//  Created by qianfeng on 16/3/12.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineJokeGifModel.h"

@interface XHDDOnlineJokeGifWindowView : UIView
/**
 *  XHDDOnlineJokeGifModel
 */
@property (nonatomic, strong) JokeGF_List *gifDetailModel;;

+ (id)jokeGifWindowView;

@end
