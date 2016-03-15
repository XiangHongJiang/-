//
//  CLVideoPlayerView.m
//  AVPlayer
//
//  Created by user on 16/3/4.
//  Copyright © 2016年 夏成龙. All rights reserved.
//

#import "CLVideoPlayerView.h"
#import "CLFullLeftViewController.h"

@interface CLVideoPlayerView ()



@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *OrientationBtn;

/*定时器*/
@property (nonatomic,strong)NSTimer *timer;

/*全屏控制器*/
@property (nonatomic,weak)CLFullLeftViewController *fullLeft;

/*是否隐藏toolView视图的判断*/
@property (nonatomic,assign)BOOL isHiddenToolView;
/*加载指示器*/
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
/*显示正在加载的label*/
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;


/**
 *  当前的视图的frame值
 */
@property (nonatomic,assign)CGRect rectFrame;

//imageView添加的点击事件
- (IBAction)tapGesure:(UITapGestureRecognizer *)sender;
- (IBAction)playOrPauseBtn:(UIButton *)sender;
- (IBAction)switchOrientation:(UIButton *)sender;
- (IBAction)sliderValueChange:(UISlider *)sender;
- (IBAction)startSlider:(id)sender;
- (IBAction)slider:(id)sender;
- (IBAction)tapSlider:(UITapGestureRecognizer *)sender;


@end

@implementation CLVideoPlayerView

+(instancetype)videoPlayerView{
    
    CLVideoPlayerView *videoPlayer = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    
    //视图创建的时候菊花开始转动
    [videoPlayer.indicatorView startAnimating];
    return videoPlayer;
}


-(void)awakeFromNib{
    
    //创建播放器
    self.player = [[AVPlayer alloc]init];
    //创建播放的图层
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    //添加图层到imageView上
    [self.imageView.layer addSublayer:self.playerLayer];
    
    //视图刚开始出现的时候隐藏工具栏
    self.toolView.alpha = 0;
    self.isHiddenToolView = YES;
    
    //设置滑块的圆点
    [self.slider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.slider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    
    [self.slider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    
  
 
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    //设置播放图层的大小
    self.playerLayer.frame = self.imageView.bounds;
    
    
}


-(void)setUrlString:(NSString *)urlString{
    
    _urlString = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    //创建播放器的item
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    //设置播放器的item
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    //开始播放
    [self.player play];
    
    
    //开启定时器设置时间
    [self timerStart];
    
    //设置播放按钮为选择状态
    self.playBtn.selected = YES;
    
    //显示指示器
    self.indicatorView.hidden = NO;
    //菊花开始转动
    [self.indicatorView startAnimating];
    
    //显示正在加载的label
    self.loadingLabel.hidden = NO;
}

///**
// *  懒加载满屏控制器
// */
//-(CLFullLeftViewController *)fullLeft{
//    
//    if (_fullLeft == nil) {
//        _fullLeft = [[CLFullLeftViewController alloc]init];
//    }
//    return _fullLeft;
//}

//开启定时器
-(void)timerStart{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//定时器事件
-(void)startTimer{
    
    //获得当前时间时间
   NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    
    //获得总时间
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    
    //如果当前时间不为0停止菊花
    if (currentTime != 0) {
      
        //视频加载到了停止菊花
        [self.indicatorView stopAnimating];
        //隐藏指示器
        self.indicatorView.hidden = YES;
        //隐藏加载的label
        self.loadingLabel.hidden = YES;
    }
    //设置slder的value
    self.slider.value = currentTime / duration;
    
    //设置时间label的值
    self.timeLabel.text = [self getTimeStringWithCurrentTime:currentTime andDuration:duration];
    
}

/**根据播放的当前时间和总时间生成时间label的text
 */
-(NSString *)getTimeStringWithCurrentTime:(NSTimeInterval)currentTime andDuration:(NSTimeInterval)duration{
    
  
    //生成当前时间的分钟和秒数
    NSInteger currentMinute = (NSInteger)currentTime / 60;
    NSInteger currentSeconds = (NSInteger)currentTime % 60;
    
  
    //生成总时间的分钟和秒数
    NSInteger durationMinute = (NSInteger)duration / 60;
    NSInteger durationSeconds = (NSInteger)duration % 60;
    
    NSString *currentString = nil;
    NSString *durationString = nil;
    
    currentString = [NSString stringWithFormat:@"%02ld:%02ld",currentMinute,currentSeconds];
    
    durationString = [NSString stringWithFormat:@"%02ld:%02ld",durationMinute,durationSeconds];
 
    return [NSString stringWithFormat:@"%@/%@",currentString,durationString];
}

//imageView的点击事件，点一次显示工具栏，两次隐藏工具栏
- (IBAction)tapGesure:(UITapGestureRecognizer *)sender {
    
    //设置工具栏的显示隐藏
    [UIView animateWithDuration:0.5 animations:^{
        
        self.isHiddenToolView = !self.isHiddenToolView;
        
       
        UINavigationController *nav = self.viewController.navigationController;
   
        nav.navigationBarHidden = !nav.navigationBarHidden;
        if (self.isHiddenToolView) {
            self.toolView.alpha = 0;
            
            if (self.fullLeft != nil) {
                nav.navigationBar.hidden = YES;
                return ;
            }
        self.frame = CGRectMake(0, 64, self.frame.size.width , self.frame.size.height);
            
        }else{
            
            self.toolView.alpha = 1;
            self.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
            
        }
    }];
}

- (IBAction)playOrPauseBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {//当前为选中状态播放
        //播放
        [self.player play];
        
        //开启定时器
        [self timerStart];
        
    }else{//当前为非选择状态暂停
        //暂停
        [self.player pause];
        
        //销毁定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}


//设置全屏
- (IBAction)switchOrientation:(UIButton *)sender {
 
    sender.selected = !sender.selected;

    UINavigationController *nav = self.viewController.navigationController;
    
    if (sender.selected) {
        
        //创建一个横屏的控制器用于横屏
        CLFullLeftViewController * fullLeft = [[CLFullLeftViewController alloc]init];
       //推出满屏控制器
        self.fullLeft = fullLeft;
        
        [nav pushViewController:self.fullLeft animated:NO];
        //保存当前视图的fame值
        self.rectFrame = self.frame;
        //将当前视图大小设置为控制器的大小
        self.frame = self.fullLeft.view.bounds;
        
        //将播放视频的View添加到横屏控制器上
        [self.fullLeft.view addSubview:self];

     
    }else{
        
        UIViewController *vc =  nav.viewControllers[nav.viewControllers.count - 2];
        //将视图添加到顶部控制器View上
        [vc.view addSubview:self];

        //让满屏控制器消失
        [nav popViewControllerAnimated:NO];

        //将视图的大小设置为原来的大小
        self.frame = self.rectFrame;

//        self.fullLeft = nil;

    }
}


//开始滑动滑块
- (IBAction)startSlider:(id)sender {
   
    //暂停定时器
    [self.timer invalidate];
    self.timer = nil;

}

//滑块滑到一定的value值就播放当前的视频
- (IBAction)sliderValueChange:(UISlider *)sender {
    //获得滑块的值
    NSTimeInterval value = sender.value;
   
    //获得总时间
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    //按照当前的value值获得当前的值
    NSTimeInterval currentTime =  duration * value;
    //设置timeLabel的值
    self.timeLabel.text = [self getTimeStringWithCurrentTime:currentTime andDuration:duration];
    
}

- (IBAction)slider:(id)sender {
    
    //停止滑动时启动定时器
    [self timerStart];
    
    //获得当前的时间
    NSTimeInterval current = CMTimeGetSeconds(self.player.currentItem.duration) * self.slider.value;
    
    //停止滑动时设置视频流的播放值
    [self.player seekToTime:CMTimeMakeWithSeconds(current, NSEC_PER_SEC)toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
   
    //开始播放
    [self.player play];
}
/**
 *  滑到的添加的点击事件
*/
- (IBAction)tapSlider:(UITapGestureRecognizer *)sender {
    
    
    //拿到当前的滑块
    UISlider *slider =  (UISlider *)sender.view;
    
    //找到点击在slider的点
    CGPoint point = [sender locationInView:slider];
    
    //设置滑块的值
    slider.value = point.x / slider.frame.size.width;
    
    [self sliderValueChange:slider];
    [self startSlider:slider];
    [self slider:slider];

}

- (void)dealloc{

    [self.player pause];
    self.player = nil;
    self.playerLayer = nil;
    
}


@end
