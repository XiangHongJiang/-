//
//  XHDDOnlineJokePureTextCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineJokeBaseModel.h"

@interface XHDDOnlineJokePureTextCell : UITableViewCell
/**
 *  pureTextDetailModel
 */
@property (nonatomic, strong) JokeBase_List *pureTextDetailModel;

//获取cell
+ (id)jokePureTextCellWithTableView:(UITableView *)tableView;
//获取高度
+(CGFloat)rowHeightWithPureTextDetailModel:(JokeBase_List *)pureTextDetailModel;

@end
