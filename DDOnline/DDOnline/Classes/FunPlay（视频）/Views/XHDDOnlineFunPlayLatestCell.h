//
//  XHDDOnlineFunPlayLatestCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineFunPlayModel.h"

@interface XHDDOnlineFunPlayLatestCell : UITableViewCell
/** *  latestRecommend */
@property (nonatomic, strong) LatestupdateModel *latestModel;
/** *  collectionView */
@property (nonatomic, weak) UICollectionView *cellCollectionView;

@end
