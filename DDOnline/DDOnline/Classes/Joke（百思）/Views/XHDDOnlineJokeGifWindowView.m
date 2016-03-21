//
//  XHDDOnlineJokeGifWindowView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/12.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeGifWindowView.h"


@interface XHDDOnlineJokeGifWindowView()

@property (weak, nonatomic) IBOutlet UIImageView *gifWindowImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *gifScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *placeHodelImageView;

@end

@implementation XHDDOnlineJokeGifWindowView

- (IBAction)tapBackWindow:(UITapGestureRecognizer *)sender {
    
    [self removeFromSuperview];    
}

+ (id)jokeGifWindowView{

    return [[NSBundle mainBundle] loadNibNamed:@"XHDDOnlineJokeGifWindowView" owner:nil options:nil].firstObject;
}


- (void)setGifDetailModel:(JokeBase_List *)gifDetailModel{

    _gifDetailModel = gifDetailModel;
    
    self.placeHodelImageView.hidden = NO;

    //动图url与 高度
    CGFloat gifHeight;
    CGFloat gifWidth;
    NSString *gifUrl;
    
    if (gifDetailModel.gif) {//gif不为空
        
        gifUrl = [self.gifDetailModel.gif.images lastObject];
        gifHeight = gifDetailModel.gif.height;
        gifWidth = gifDetailModel.gif.width;
        
    }else{//image不为空
        gifHeight = gifDetailModel.image.height;
        gifWidth = gifDetailModel.image.width;
        gifUrl = [self.gifDetailModel.image.download_url lastObject];
    }
    //比例
    CGFloat ratio = gifWidth / (JScreenWidth - 60);
    CGFloat gifImageViewHeight = gifHeight / ratio;
    //布局
    self.frame = CGRectMake(0, 0, JScreenWidth, JScreenHeight);
    self.gifScrollView.frame = CGRectMake(0, 0, JScreenWidth, JScreenHeight);
    self.gifScrollView.contentSize = CGSizeMake(0, gifImageViewHeight);
    
    self.placeHodelImageView.frame = CGRectMake(0, 0, JScreenWidth - 60, 200);
    self.placeHodelImageView.center = self.gifScrollView.center;
    
    self.gifWindowImageView.frame = CGRectMake(30, 30, JScreenWidth - 60, gifImageViewHeight);
    
    if (gifImageViewHeight < JScreenHeight - 60) {
        
        self.gifWindowImageView.center = self.center;
    }
    
    //设置
    [self.gifWindowImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:gifUrl] andPlaceholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        JLog(@"%f",receivedSize * 1.0 / expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.placeHodelImageView.hidden = YES;
        
    }];

}
@end
