//
//  XHDDOnlineCategorysDetailCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/10.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineCategorysDetailCell.h"

@interface XHDDOnlineCategorysDetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *favorite;

@end

@implementation XHDDOnlineCategorysDetailCell

- (void)setDetailModel:(CategoryDetailResult *)detailModel{

    _detailModel = detailModel;

#warning 赋值数据
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.squareCover]];
    self.title.text = detailModel.bangumi_title;
    self.author.text = detailModel.alias;
    
    NSString *favorite = detailModel.favorites;
    float favo = [favorite intValue]/10000.0;
    
    if (favo > 0) {
        
        self.favorite.text = [NSString stringWithFormat:@"%2.f万人 订阅",favo];
    }
    else{
    
        self.favorite.text = [NSString stringWithFormat:@"%@人 订阅",favorite];
    }
    
    if ([detailModel.is_finish isEqualToString:@"1"]) {
        
        self.number.text = [NSString stringWithFormat:@"已完结，%@话全",detailModel.total_count];
    }
    else{
    
        self.number.text = [NSString stringWithFormat:@"连载中，更新至%02d",[detailModel.newest_ep_index intValue]];
    }

}

@end
