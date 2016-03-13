//
//  XHDDOnlineCategoryDetailCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/8.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineCategoryDetailCell.h"

@interface XHDDOnlineCategoryDetailCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *total_countLabel;

@end

@implementation XHDDOnlineCategoryDetailCell


- (void)setModel:(DeepList *)model{
    
    _model = model;
        
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    self.titleLabel.text = model.title;
    self.total_countLabel.text = [NSString stringWithFormat:@"%@话全",model.total_count];
}
@end
