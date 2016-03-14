//
//  XHDDOnlineJokeBaseModel.m
//  DDOnline
//
//  Created by qianfeng on 16/3/13.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeBaseModel.h"

@implementation XHDDOnlineJokeBaseModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [JokeBase_List class]};
}
@end
@implementation JokeBase_Info

@end


@implementation JokeBase_List

+ (NSDictionary *)objectClassInArray{
    return @{@"tags" : [JokeBase_Tags class]};
}
//textHeight
- (void)setText:(NSString *)text{

    _text = text;
    
    self.textHeight =[XHUtils calculateSizeWithText:text maxSize:CGSizeMake(JScreenWidth - 10, CGFLOAT_MAX) font:15].height;
    
}
//imageHeight
- (void)setImage:(JokeGF_Image *)image{

    _image = image;
    
    
    
}
//gifHeight
- (void)setGif:(JokeGF_Gif *)gif{

    _gif = gif;
}
//videoHeight
- (void)setVideo:(JokeVideo_Video *)video{

    _video = video;
}

@end


@implementation JokeBase_U

@end


@implementation JokeBase_Tags

@end


//video
@implementation JokeVideo_Video

@end
//gif
@implementation JokeGF_Gif


@end
//gif
@implementation JokeGF_Image

@end

