//
//  XHQuickNavView.m
//  XHQuickGuideView
//
//  Created by qianfeng on 16/3/1.
//  Copyright © 2016年 JXH. All rights reserved.
//

#import "XHQuickNavView.h"

//#define JSelfW self.bounds.size.width
//#define JSelfH self.bounds.size.height
//
//#define JLabelH 20
//#define JMargin 16
//
//#define JLineViewHeight 2

//#define JTopSpace 64
//#define JQuickNavHeight 50

@interface XHQuickNavView()<UIScrollViewDelegate>
/** *  管理的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** *  管理跟随滚动小视图 */
@property (nonatomic, weak) UIView * redView;
/** *  管理最后一次点击的Btn */
@property (nonatomic, weak) UIButton * lastBtn;
/** *  管理的所有Btn数组 */
@property (nonatomic, strong) NSMutableArray *allBtnArray;
@end

@implementation XHQuickNavView
#pragma mark - init
/** *  类方法返回快速导航视图 */
+ (instancetype)quikeGuideView{
    
    return [[self alloc] initWithFrame:CGRectZero];
}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
      
        //1.初始化数组
        self.allBtnArray = [NSMutableArray new];
        
        //2.设置子视图
        [self configSubViews];
        
    }
    return self;
}
/** 添加子视图 */
- (void)configSubViews{
    
    //1.添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //添加到视图
    [self addSubview:scrollView];
    //设置成员
    self.scrollView = scrollView;
    //设置属性
    scrollView.pagingEnabled = NO;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    
    //2.添加红色引导View
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:redView];
    self.redView = redView;
    
}
/** *  添加到父视图确定frame */
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    CGFloat itemW = JScreenWidth - 100;
    CGFloat itemH = JQuickNavHeight;
    //设置视图的frame
    self.frame = CGRectMake(itemX, itemY, itemW, itemH);
    self.backgroundColor = [UIColor whiteColor];
    //设置scrollView的frame
    self.scrollView.frame = CGRectMake(itemX, 0, itemW, itemH);//预留红色小视图
    //设置默认红条frame
    self.redView.frame = CGRectMake(itemX, itemH - JLineViewHeight, itemW  / 6, JLineViewHeight);
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
}
#pragma mark - setter or getter
- (void)setQuickNavNameArray:(NSArray *)quickNavNameArray{

    //1.基本赋值
    _quickNavNameArray = quickNavNameArray;
    
    //2.创建
    //确定Y，H
    CGFloat itemY = 2;
    CGFloat itemH = JQuickNavHeight - JLineViewHeight;
    CGFloat endX = 0;
    
    for (int i = 0; i < quickNavNameArray.count; i ++) {
       
        //create And add
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:button];
        
        //set
        [button setTitle:quickNavNameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.800] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.800] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = JDefaultTag + i;
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self.allBtnArray addObject:button];
        //确定尺寸
        CGSize size = [self calculateSizeWithText:quickNavNameArray[i] andMaxSize:CGSizeMake(JSelfW, JLabelH) andFontSize:JLabelH];
        //确定X,W
        CGFloat itemW = size.width;
        CGFloat itemX = endX + JMargin;
        endX = itemX + itemW;
        
        button.frame = CGRectMake(itemX, itemY, itemW, itemH);        

        //设置默认选中第0个
        if (i == 0) {
            
            _lastBtn = button;
            [self btnClick:button];
        }

    }
    
    //3.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(endX, 0);

    
}
- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [self chageBtnState:self.allBtnArray[currentIndex]];
}
#pragma mark - response
/** *  btn点击响应 */
- (void)btnClick:(UIButton *)btn{
    //改变状态
    [self chageBtnState:btn];

    //执行代理方法,判空，不为空执行
    if (self.clickIndex) {
         self.clickIndex(btn.tag - JDefaultTag);
    }
   
}
- (void)chageBtnState:(UIButton *)btn{
    //设置最后一次点击的Btn的选中为NO，开启交互性
    _lastBtn.selected = NO;
    _lastBtn.userInteractionEnabled = YES;
    
    //设置当前点击选中，关闭交互性
    btn.selected = YES;
    btn.userInteractionEnabled = NO;
    
    //设置当前为最后一次点击
    _lastBtn = btn;
    
    //改变红色View的frame
    [UIView animateWithDuration:0.5 animations:^{
         self.redView.frame = CGRectMake(btn.frame.origin.x, self.redView.frame.origin.y, btn.frame.size.width, JLineViewHeight);
    }];
   

}
#pragma mark - toolMethod
- (NSValue *)CGRectToNSValue:(CGRect)rect{
    NSValue *value = [NSValue valueWithCGRect:rect];
    return value;
}
- (CGSize)calculateSizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFontSize:(CGFloat)font{
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

@end
