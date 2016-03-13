//
//  XHDDOnlineJokeController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineJokeController.h"
#import "XHQuickNavView.h"
#import "XHDDOnlineJokeCell.h"

@interface XHDDOnlineJokeController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
/** *管理的collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** *  quickNavView */
@property (nonatomic, weak) XHQuickNavView * quickNavView;
/** *  quickNavNameArray */
@property (nonatomic, copy) NSArray *quickNavNameArray;
@end

@implementation XHDDOnlineJokeController

- (void)loadView{
    [super loadView];
    
    //添加快速导航视图
    [self addQuickNavView];
    [self setUpSubViews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    
    
}
#pragma mark - lazyLoad
- (NSArray *)quickNavNameArray{

    if (_quickNavNameArray == nil) {
        
        _quickNavNameArray = @[@"段子手",@"Gif",@"嘿,Player"];
    }
    
    return _quickNavNameArray;
}

#pragma mark - setupUI

/**添加快速导航视图*/
- (void)addQuickNavView{

    XHQuickNavView *quickNavView = [XHQuickNavView quikeGuideView];
    self.navigationItem.titleView = quickNavView;
    quickNavView.quickNavNameArray = self.quickNavNameArray;
    self.quickNavView = quickNavView;
    
    //防止循环引用对象
    __weak typeof (self) weakSelf = self;
    quickNavView.clickIndex = ^(NSInteger index){
        
        if (weakSelf.collectionView) {
            
            weakSelf.collectionView.contentOffset = CGPointMake(JScreenWidth * index, weakSelf.collectionView.contentOffset.y);
        }
        
        JLog(@"%ld",index);
    };

}
/**设置collectionView及其布局*/
- (void)setUpSubViews{
    
    //1.布局
    //create
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //set flowLayout
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //2.collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, JTopSpace , JScreenWidth, JScreenHeight - JTopSpace - JTabBarHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    //    collectionView.backgroundColor = JColorBg;
    
    self.collectionView = collectionView;
    //设置collectionView的位置及大小
    
    //set CollectionView
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    //3.注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"XHDDOnlineJokeCell" bundle:nil] forCellWithReuseIdentifier:@"XHDDOnlineJokeCell"];
    
    //4.注册组头组尾
    
    
}
#pragma mark - delegate
/**返回页数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.quickNavNameArray.count;
}
/**赋值*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XHDDOnlineJokeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XHDDOnlineJokeCell" forIndexPath:indexPath];
    
    cell.jokeType = (JokeType)indexPath.row;
    
    return cell;
}
/**返回每个item大小*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.collectionView.frame.size;
    
}
/**滚动换页*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //开始滚动，动态更新快速导航视图状态
    self.quickNavView.currentIndex = (scrollView.contentOffset.x + JScreenWidth * 0.5) / JScreenWidth;
}

@end
