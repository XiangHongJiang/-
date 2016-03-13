//
//  XHDDOnlineLatestUpdateCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/7.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineLatestUpdateCell.h"
#import "UIImageView+WebCache.h"

@interface XHDDOnlineLatestUpdateCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *onlineNumber;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestPlay;
@property (weak, nonatomic) IBOutlet UILabel *latestTime;

@end

@implementation XHDDOnlineLatestUpdateCell

- (void)awakeFromNib{

    self.imageView.layer.cornerRadius = 4;
    self.imageView.layer.masksToBounds = YES;
    
    self.onlineNumber.layer.cornerRadius = 3;
    self.onlineNumber.layer.masksToBounds = YES;
}

- (void)setLatestModel:(LatestList *)latestModel{

    _latestModel = latestModel;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:latestModel.cover]];
    self.onlineNumber.text = [NSString stringWithFormat:@"%@人在看",latestModel.watchingCount] ;
    self.nameLabel.text = latestModel.title;
    self.latestPlay.text = [NSString stringWithFormat:@"全%@话",latestModel.total_count];
    self.latestTime.text = [NSString stringWithFormat:@"第%@话",latestModel.newest_ep_index];

}

@end
