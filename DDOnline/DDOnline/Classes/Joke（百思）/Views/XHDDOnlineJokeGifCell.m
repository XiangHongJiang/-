//
//  XHDDOnlineJokeGifCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeGifCell.h"
#import "XHDDOnlineJokeGifWindowView.h"

@interface XHDDOnlineJokeGifCell()

@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;//commend
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profile_addv_authen;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *isGifImage;

@end

@implementation XHDDOnlineJokeGifCell
#pragma mark - 点击了动图
- (void)tapGifImageView:(UITapGestureRecognizer *)sender {
    
    //添加到window
   
    XHDDOnlineJokeGifWindowView *gifView = [XHDDOnlineJokeGifWindowView jokeGifWindowView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:gifView];

    gifView.gifDetailModel = self.gifDetailModel;
 
}
#pragma mark - 注册复用
+ (id)jokeGifCellWithTableView:(UITableView *)tableView{
    
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    return [tableView dequeueReusableCellWithIdentifier:className];
}
#pragma mark - Xib加载成功
- (void)awakeFromNib {
    
    self.headerImageView.layer.cornerRadius = 15;
    self.headerImageView.layer.masksToBounds = YES;
    
    // 添加手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGifImageView:)];
    
    self.gifImageView.userInteractionEnabled = YES;
    
    [self.gifImageView addGestureRecognizer:tapGR];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - 赋值模型
- (void)setGifDetailModel:(JokeBase_List *)gifDetailModel{

    _gifDetailModel = gifDetailModel;
    NSString *headerUrlStr = gifDetailModel.u.header[0];
    self.profile_addv_authen.hidden = !gifDetailModel.u.is_vip;
    
    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:headerUrlStr]];
    //用户名
    self.nameLabel.text = gifDetailModel.u.name;
    //时间
    self.timeLabel.text = gifDetailModel.passtime;
    //内容
    self.contentLabel.text = gifDetailModel.text;
    
    //图url
    NSString *gifUrl;
    CGFloat gifHeight;
    CGFloat gifWidth;
    if (gifDetailModel.gif) {//gif不为空
        
        gifUrl = gifDetailModel.gif.images[0];
        gifHeight = gifDetailModel.gif.height;
        gifWidth = gifDetailModel.gif.width;
        self.isGifImage.hidden = NO;
        
    }else{//image不为空
    
        gifUrl = gifDetailModel.image.download_url[0];
        gifHeight = gifDetailModel.image.height;
        gifWidth = gifDetailModel.image.width;
        self.isGifImage.hidden = YES;
    }
    
    //图
    [self.gifImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:gifUrl] andPlaceholderImage:[UIImage imageNamed:@"placeHolder.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        JLog(@"%f",receivedSize * 1.0 / expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (!gifDetailModel.gif) {
            
            CGSize size  = image.size;
            self.gifImageView.image = [self clipImage:image withRect:CGRectMake(0, 0, size.width, size.height - 50)];
        }
        
        
    }];

    
    // 设置按钮文字
    [self setupButtonTitle:self.dingBtn count:[gifDetailModel.up integerValue] placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:gifDetailModel.down placeholder:@"踩"];
    [self setupButtonTitle:self.shareBtn count:[gifDetailModel.bookmark integerValue] placeholder:@"分享"];
    [self setupButtonTitle:self.pinglunBtn count:[gifDetailModel.comment integerValue] placeholder:@"评论"];
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

#pragma mark - 类方法返回高度
+ (CGFloat)rowHeightWithgifDetailModel:(JokeBase_List *)gifDetailModel{
    
    CGSize size = [XHUtils calculateSizeWithText:gifDetailModel.text maxSize:CGSizeMake(JScreenWidth - 20, CGFLOAT_MAX) font:15];
    
    //图url
//    CGFloat gifHeight;
//    CGFloat gifWidth;
//    
//    if (gifDetailModel.gif) {//gif不为空
//        gifHeight = gifDetailModel.gif.height;
//        gifWidth = gifDetailModel.gif.width;
//        
//    }else{//image不为空
//        gifHeight = gifDetailModel.image.height;
//        gifWidth = gifDetailModel.image.width;
//    }
//    CGFloat ratio = gifWidth / (JScreenWidth - 20);
//    CGFloat gifImageViewHeight = gifHeight / ratio;
 
    return size.height + 110 + 200;
    
}

- (UIImage *)clipImage:(UIImage *)image withRect:(CGRect)rect{
    
    CGImageRef cgImage = image.CGImage;
    
    cgImage = CGImageCreateWithImageInRect(cgImage,rect);
    
    image = [UIImage imageWithCGImage:cgImage];
    
    return image;
}
@end
