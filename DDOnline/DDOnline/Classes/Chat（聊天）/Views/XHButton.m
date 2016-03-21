//
//  XHButton.m
//  DDOnline
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHButton.h"

@implementation XHButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        [self changeSkin];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSkin) name:@"changeSkin" object:nil];
    }
    return self;
}
- (void)changeSkin{
    
    NSString *addressPre =  [[NSUserDefaults standardUserDefaults] objectForKey:@"skinAddress"];
    
    NSString *skinPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/themeColor.plist",addressPre] ofType:nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:skinPath];
    
    NSArray *rgbArray = [dict[@"navigationColor"] componentsSeparatedByString:@","];
    
    self.backgroundColor = JColorRGBA([rgbArray[0] floatValue], [rgbArray[1]floatValue], [rgbArray[2]floatValue],0.6);
    
}

//设置title位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGRect newRect = contentRect;
    
    newRect.origin.x = 30;
    newRect.origin.y = 5;
    newRect.size.width = newRect.size.width * 0.6;
    newRect.size.height = newRect.size.height - 10;
    return newRect;
}
//设置image位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    CGRect newRect = contentRect;
    
    newRect.size.width = 7;
    newRect.size.height = 11;
    newRect.origin.x = contentRect.size.width - 30 - newRect.size.width;
    newRect.origin.y = (contentRect.size.height - newRect.size.height) * 0.5;
    
    return newRect;
}
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
