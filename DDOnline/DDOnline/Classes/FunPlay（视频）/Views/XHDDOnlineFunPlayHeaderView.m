//
//  XHDDOnlineFunPlayHeaderView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFunPlayHeaderView.h"

@implementation XHDDOnlineFunPlayHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{

    XHDDOnlineFunPlayHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"reuseHeadView"];
    if (header == nil) {
        
        header = [[XHDDOnlineFunPlayHeaderView alloc] initWithReuseIdentifier:@"reuseHeadView"];
    }
    header.contentView.backgroundColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
    
    header.layer.cornerRadius = 2;    
    header.layer.masksToBounds = YES;
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //添加子视图
        [self setupSubViews];
    }
    
    return self;
}
- (void)setupSubViews{

    //1.imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.headerImageView = imageView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(2);
        make.bottom.equalTo(-2);
        make.left.equalTo(10);
        make.width.equalTo(26);
    }];
    
    //2.nameLabel
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor blackColor];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.top.equalTo(self.contentView);
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
        make.width.equalTo(150);
    }];
    
//    self.contentView.backgroundColor = JColorNavBg;
    
    //3.进去看看Label
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = JColorGray;
    
//    label.layer.cornerRadius = 4;
//    label.layer.masksToBounds = YES;
    
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:13];
//    label.text = @"进去看看";
//    [self.contentView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-10);
//        make.top.equalTo(2);
//        make.width.equalTo(60);
//        make.height.equalTo(25);
//    }];
}
@end
