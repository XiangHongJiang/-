//
//  XHDDOnlineRecommendCategoryDetailCell.m
//  UIday16-04CollectionView3D
//
//  Created by qianfeng on 16/3/8.
//  Copyright (c) 2016年 JXH. All rights reserved.
//

#import "XHDDOnlineRecommendCategoryDetailCell.h"

@interface XHDDOnlineRecommendCategoryDetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tagName;


@end

@implementation XHDDOnlineRecommendCategoryDetailCell

- (void)setCategoryDetailModel:(RecommendCategoryModel *)categoryDetailModel{

    _categoryDetailModel = categoryDetailModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:categoryDetailModel.cover]];
    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    
    self.tagName.text = categoryDetailModel.tag_name;

}

@end
