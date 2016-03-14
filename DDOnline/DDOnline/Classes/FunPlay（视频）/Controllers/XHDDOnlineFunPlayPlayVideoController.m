//
//  XHDDOnlineFunPlayPlayVideoController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/10.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineFunPlayPlayVideoController.h"
#import "XHDDOnlineFunPlayUrlModel.h"
#import "CLVideoPlayerView.h"

@interface XHDDOnlineFunPlayPlayVideoController ()
/** *  cid */
@property (nonatomic, copy) NSString *cid;
/** *  url */
@property (nonatomic, copy) NSString *playUrl;
/** *  videoView */
@property (nonatomic, weak) CLVideoPlayerView *videoView;
@end

@implementation XHDDOnlineFunPlayPlayVideoController

- (void)loadView{

    [super loadView];
    
    [self addVideoView];
}

- (void)addVideoView{

    CLVideoPlayerView *videoView = [CLVideoPlayerView videoPlayerView];
    
    videoView.frame = CGRectMake(0, 64, JScreenWidth, JScreenWidth * 9 / 16.0);
    [self.view addSubview:videoView];
    self.videoView = videoView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求数据
    [self requestCid];
}
//请求cid
- (void)requestCid{

    [XHNetHelp getDataWithPath:[NSString stringWithFormat:kFunPlayAidToCidUrl,self.aid] andParams:nil andComplete:^(BOOL succeed, id result) {
       
        if(succeed){
        
            //解析Cid
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *list = dict[@"list"][0];
           

          self.cid = [NSString stringWithFormat:@"%@",list[@"CID"]];
            //请求playUrl
            [self requestPlayUrl];
        }
    }];
    
}
//请求播放url
- (void)requestPlayUrl{

    static int i = 0;
    
    [XHNetHelp getDataWithPath:[NSString stringWithFormat:kFunPlayCidToPlayUrl,self.cid] andParams:nil andComplete:^(BOOL succeed, id result) {
       
        if (succeed) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];

            XHDDOnlineFunPlayUrlModel *urlModel = [XHDDOnlineFunPlayUrlModel mj_objectWithKeyValues:dict];
            
           PlayDurl *PlayUrl = urlModel.durl[0];

            self.playUrl = PlayUrl.url;
            
           [self playVideo:PlayUrl.url];
        }
        else{
        
            if (i < 2) {
               [self requestPlayUrl];
            }
            i ++ ;
            if (i == 3) {
                i = 0;
            }
        }
    }];
    
}
// 通过URL播放视频
- (void)playVideo:(NSString *)url{
    
    JLog(@"%@",url);

    self.videoView.urlString = url;

    JLog(@"%@",url);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - Table view data source


@end
