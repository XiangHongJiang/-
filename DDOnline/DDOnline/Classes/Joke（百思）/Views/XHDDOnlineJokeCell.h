//
//  XHDDOnlineJokeCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum JokeType{

    JokeTypeDuanzi,//段子
    JokeTypeGif,//图片
    JokeTypeVideo//视频
    
}JokeType;

@interface XHDDOnlineJokeCell : UICollectionViewCell
/**
 *  JokeType
 */
@property (nonatomic, assign) JokeType jokeType;

@end
