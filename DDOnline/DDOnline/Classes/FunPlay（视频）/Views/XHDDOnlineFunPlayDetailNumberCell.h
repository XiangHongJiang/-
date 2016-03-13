//
//  XHDDOnlineFunPlayDetailNumberCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/9.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineFunPlayDetailModel.h"

@protocol  XHDDOnlineFunPlayDetailNumberCell<NSObject>

@end

@interface XHDDOnlineFunPlayDetailNumberCell : UITableViewCell
/** *  count集数 */
@property (nonatomic, assign) int count;
/** *  desc描述 */
@property (nonatomic, copy) NSString *funPlayDesc;
/** *  详情数组*/
@property (nonatomic, copy) NSArray *detailFunPlayArray;


+ (CGFloat)rowHeight;

@end
