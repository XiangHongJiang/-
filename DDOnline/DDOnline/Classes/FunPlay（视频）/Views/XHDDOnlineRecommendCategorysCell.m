//
//  XHDDOnlineRecommendCategorysCell.m
//  DDOnline
//
//  Created by qianfeng on 16/3/8.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineRecommendCategorysCell.h"
#import "XHDDOnlineRecommendCategoryDetailCell.h"
#import "XHDDOnlineMy3DLayout.h"

#import "XHDDOnlineFunPlayCategoryDetailController.h"
#import "XHDDOnlineRootTabBarController.h"

@interface XHDDOnlineRecommendCategorysCell()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView * collectionView;

@end

@implementation XHDDOnlineRecommendCategorysCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //1.创建collectionView
        [self creatCollectionView];
        
        //2.注册cell
        [self registCollectionView];
        
    }
    return  self;
}
//注册cell
- (void)registCollectionView{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XHDDOnlineRecommendCategoryDetailCell" bundle:nil] forCellWithReuseIdentifier:@"XHDDOnlineRecommendCategoryDetailCell"];
}
//创建collectionView
- (void)creatCollectionView{
    
    //1.自定义布局
    XHDDOnlineMy3DLayout *layout = [[XHDDOnlineMy3DLayout alloc] init];
    
    //2.创建带布局的collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 8, JScreenWidth - JPedding, 200) collectionViewLayout:layout];
    
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.backgroundColor = JColorNavBg;
    
    collectionView.contentOffset = CGPointMake(JSelfW, 0);
    
    //3.设置代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
}

- (void)setRecommendCategory:(NSArray *)recommendCategory{

    _recommendCategory = recommendCategory;
    
    [self.collectionView reloadData];
}

#pragma mark - 代理相关
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.recommendCategory.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XHDDOnlineRecommendCategoryDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XHDDOnlineRecommendCategoryDetailCell" forIndexPath:indexPath];
#warning 3D
    cell.categoryDetailModel = self.recommendCategory[indexPath.row];
    
    return cell;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(8, 0, 8, 0);
}

#pragma mark -  关于循环
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    
    
    //无限循环....
    float currentOffset = _scrollView.contentOffset.x;//当前偏移量
    
    int numCount = (int)[self.collectionView numberOfItemsInSection:0];//总照片数 10
    float itemW = _scrollView.frame.size.width;//视图宽度
    
    if (numCount >= 3)
    {
        if (currentOffset < itemW / 2) {//当前偏移量小于视图宽度的一半，则出边界，让其显示最后一张
            [_scrollView setContentOffset:CGPointMake(currentOffset + itemW * numCount, 0)];
        }
        else if (currentOffset > itemW / 2 + itemW * numCount)
        {
            [_scrollView setContentOffset:CGPointMake(currentOffset - itemW *numCount, 0)];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //获取下标
    int index = (collectionView.contentOffset.x + collectionView.frame.size.width * 0.5) / collectionView.frame.size.width;
    RecommendCategoryModel *model = self.recommendCategory[index-1];
    
//    JLog(@"%d,indexpath:%ld",index,indexPath.row);
    
    XHDDOnlineFunPlayCategoryDetailController *detailCtrl = [[XHDDOnlineFunPlayCategoryDetailController alloc] init];
    //赋值
    detailCtrl.tag_id = model.tag_id;
    detailCtrl.navigationItem.title = model.tag_name;
    
    RESideMenu *sideMenu = (RESideMenu *)[UIApplication sharedApplication].keyWindow.rootViewController;
    XHDDOnlineRootTabBarController *tbc = sideMenu.contentViewController.childViewControllers[0];
    UINavigationController *nav = (UINavigationController *)tbc.selectedViewController;
    [nav pushViewController:detailCtrl animated:YES];
    
}


@end
