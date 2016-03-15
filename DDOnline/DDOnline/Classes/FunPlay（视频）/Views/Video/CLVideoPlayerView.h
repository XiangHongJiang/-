//
//  CLVideoPlayerView.h
//  AVPlayer
//
//  Created by user on 16/3/4.
//  Copyright © 2016年 夏成龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface CLVideoPlayerView : UIView
@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)AVPlayerLayer *playerLayer;

@property (nonatomic,copy)NSString *urlString;

+(instancetype)videoPlayerView;

@end
