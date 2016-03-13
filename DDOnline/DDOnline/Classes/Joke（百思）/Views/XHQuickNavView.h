//
//  XHQuickNavView.h
//  XHQuickGuideView
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 JXH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^quickNavViewClickBlock)(NSInteger index);

@interface XHQuickNavView : UIView
/** *  传入名字数组 */
@property (nonatomic, copy) NSArray *quickNavNameArray;
/** *  点击事件Block */
@property (nonatomic, copy) quickNavViewClickBlock clickIndex;
/** *  当前下标 */
@property (nonatomic, assign) NSInteger currentIndex;
/** *  类方法返回视图 */
+ (instancetype)quikeGuideView;
@end
