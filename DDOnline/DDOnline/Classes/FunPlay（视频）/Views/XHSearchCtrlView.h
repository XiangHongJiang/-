//
//  XHsearchCtrlView.h
//  Perfect_food
//
//  Created by qianfeng on 16/1/23.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHSearchCtrlView;

@protocol SearchCtrlViewDelegate <NSObject>
/**
 *  点击了热门搜索Name
 */
- (void)searchCtrlView:(XHSearchCtrlView *)searchView didSelectedHotSearch:(NSString *)hotSearchName;
/**
 *  点击了历史搜索Name
 */
- (void)searchCtrlView:(XHSearchCtrlView *)searchView didSelectedHistorySearch:(NSString *)historySearchName;
/**
 *  点击了语言输入
 */
- (void)searchCtrlViewDidSelectedSoundInput:(XHSearchCtrlView *)searchView;
/**
 *  点击了清空历史
 */
- (void)searchCtrlViewDidSelectedClearHistorySearch:(XHSearchCtrlView *)searchView;
@end

@interface XHSearchCtrlView : UIView
/**
 *  传入热门搜索数组
 */
@property (nonatomic, copy) NSArray *hotSearchArray;
/**
 *  传入历史搜索数组
 */
@property (nonatomic, copy) NSArray *historySearchArray;
/**
 *  代理
 */
@property (nonatomic, weak) id<SearchCtrlViewDelegate>delegate;
/**
 *  快速创建搜索界面
 */
+ (instancetype)searchCtrlView;
@end
