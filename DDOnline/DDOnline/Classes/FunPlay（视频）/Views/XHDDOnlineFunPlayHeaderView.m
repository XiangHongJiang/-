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
    
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:header selector:@selector(changeSkin) name:@"changeSkin" object:nil];
    
    //更换颜色
    [header changeSkin];
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
}

- (void)changeSkin{

    NSString *addressPre =  [[NSUserDefaults standardUserDefaults] objectForKey:@"skinAddress"];
    
    NSString *skinPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/themeColor.plist",addressPre] ofType:nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:skinPath];
    
    NSArray *rgbArray = [dict[@"navigationColor"] componentsSeparatedByString:@","];
    
    self.contentView.backgroundColor = JColorRGBA([rgbArray[0] floatValue], [rgbArray[1]floatValue], [rgbArray[2]floatValue],0.6);
    
}
@end
