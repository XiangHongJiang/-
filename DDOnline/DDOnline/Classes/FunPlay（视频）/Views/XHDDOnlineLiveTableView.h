//
//  XHDDOnlineLiveTableView.h
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHDDOnlineLiveTableView : UITableView
/** *  管理的直播的数据源 */
@property (nonatomic, copy) NSArray *liveDataArray;
/** *  创建加载视图 */
+ (instancetype)liveTableView;

@end
