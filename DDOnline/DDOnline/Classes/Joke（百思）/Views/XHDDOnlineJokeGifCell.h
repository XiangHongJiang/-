//
//  XHDDOnlineJokeGifCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineJokeBaseModel.h"

@interface XHDDOnlineJokeGifCell : UITableViewCell

/**
 *  XHDDOnlineJokeGifModel
 */
@property (nonatomic, strong)  JokeBase_List *gifDetailModel;

+(id)jokeGifCellWithTableView:(UITableView *)tableView;
//获取高度
+(CGFloat)rowHeightWithgifDetailModel:(JokeBase_List *)gifDetailModel;
@end
