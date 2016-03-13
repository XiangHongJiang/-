//
//  XHDDOnlineFunPlayTableView.h
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineFunPlayModel.h"

@interface XHDDOnlineFunPlayTableView : UITableView
/** *  管理番剧的模型 */
@property (nonatomic, strong) XHDDOnlineFunPlayModel *funPlayModel;
/** *  创建加载视图 */
+ (instancetype)funPlayTableView;
@end
