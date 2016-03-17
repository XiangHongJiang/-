//
//  XHDDOnlineJokeVideoCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeVideoCell.h"
#import "CLVideoPlayerView.h"

@interface XHDDOnlineJokeVideoCell()

//底部点赞
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;//commend
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;

//头像设置
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profile_addv_authen;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

//内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *playVideoBtn;

//播放设置
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/**
 *  playView
 */
@property (nonatomic, weak) CLVideoPlayerView *playView;

@end

@implementation XHDDOnlineJokeVideoCell

- (CLVideoPlayerView *)playView{

    if (_playView == nil) {
        
        CLVideoPlayerView *view = [CLVideoPlayerView videoPlayerView];
        view.frame = CGRectMake(0, 0, JScreenWidth - 20, 200);
        self.playView = view;
        
        [self.gifImageView addSubview:view];
    }
    
    return _playView;
}

+ (id)jokeVideoCellWithTableView:(UITableView *)tableView{
    
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];

}
//点击播放
- (IBAction)playVideoAction:(UIButton *)sender {
    
    JLog(@"播放");
    [self bringSubviewToFront:self.playView];
    
    self.selected = !self.selected;
    if (self.selected == NO) {
        [self.playView.player pause];
        [self sendSubviewToBack:self.playView];
        return;
    }
    else if (self.playView.urlString.length >0){
    
        [self.playView.player play];
        return;
    }
    
    self.playView.urlString = [self.videoDetailModel.video.video firstObject];
    
}


- (void)setVideoDetailModel:(JokeBase_List *)videoDetailModel{

    _videoDetailModel = videoDetailModel;
    
//    JLog(@"%@",videoDetailModel);
    
    NSString *headerUrlStr = videoDetailModel.u.header[0];
    self.profile_addv_authen.hidden = !videoDetailModel.u.is_vip;
    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:headerUrlStr]];
    //用户名
    self.nameLabel.text = videoDetailModel.u.name;
    //时间
    self.timeLabel.text = videoDetailModel.passtime;
    //内容
    self.contentLabel.text = videoDetailModel.text;

    
    //播放图片
    [self.gifImageView sd_setImageWithURL:[NSURL URLWithString:videoDetailModel.video.thumbnail[0]]];
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放", videoDetailModel.video.playcount];
    
    // 时长
    NSInteger minute = videoDetailModel.video.duration / 60;
    NSInteger second = videoDetailModel.video.duration % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
   
    // 设置按钮文字
    [self setupButtonTitle:self.dingBtn count:[videoDetailModel.up integerValue] placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:videoDetailModel.down placeholder:@"踩"];
    [self setupButtonTitle:self.shareBtn count:[videoDetailModel.bookmark integerValue] placeholder:@"分享"];
    [self setupButtonTitle:self.pinglunBtn count:[videoDetailModel.comment integerValue] placeholder:@"评论"];
    
}

/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)rowHeightWithvideoDetailModel:(JokeBase_List *)videoDetailModel{

    return videoDetailModel.textHeight + 110 + 200;
}
@end
