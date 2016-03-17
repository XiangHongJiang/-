//
//  XHDDOnlineChatContactsTableView.h
//  DDOnline
//
//  Created by qianfeng on 16/3/15.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHDDOnlineChatContactsTableView : UITableView
/**
 *  联系人数组
 */
@property (nonatomic, copy) NSArray *contactsArray;
/**
 *  进入编辑状态
 */
@property (nonatomic, assign) BOOL enterEditting;
/**
 *  删除
 */
@property (nonatomic, assign) BOOL deleteAction;

+ (instancetype)chatContactsTableView;

@end
