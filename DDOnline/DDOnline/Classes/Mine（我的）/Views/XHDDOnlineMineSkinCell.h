//
//  XHDDOnlineMineSkinCell.h
//  DDOnline
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDDOnlineMineSkinModel.h"

@interface XHDDOnlineMineSkinCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
/**
 *  skinModel
 */
@property (nonatomic, strong) XHDDOnlineMineSkinModel *skinModel;

@end
