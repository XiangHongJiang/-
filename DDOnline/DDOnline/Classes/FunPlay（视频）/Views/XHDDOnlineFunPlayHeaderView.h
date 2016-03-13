//
//  XHDDOnlineFunPlayHeaderView.h
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHDDOnlineFunPlayHeaderView : UITableViewHeaderFooterView
/** *  nameLabel */
@property (nonatomic, weak) UILabel * nameLabel;
/** *  headerImageView */
@property (nonatomic, weak) UIImageView *headerImageView;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
