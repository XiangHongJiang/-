//
//  XHDDOnlineMy3DLayout.m
//  DDOnline
//
//  Created by qianfeng on 16/3/8.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineMy3DLayout.h"

@implementation XHDDOnlineMy3DLayout
//设置第组的包含内容
-(CGSize)collectionViewContentSize{
    
    CGFloat width = self.collectionView.frame.size.width *([self.collectionView numberOfItemsInSection:0] + 2);//默认多2页，用于循环滚动。
    CGFloat height = self.collectionView.frame.size.height;//默认水平滚动
    
    return CGSizeMake(width, height);
    
}
//设置每次改变bounds都销毁当前布局。则重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark - 设置每个Item的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //设置3D效果
    
    //快速创建相应位置的属性对象
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置相应位置的属性
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;//collectionView宽度
    CGFloat currentX = self.collectionView.contentOffset.x;//当前偏移量
    CGFloat arc = M_PI * 2.0f;//360°，弧度//
    NSInteger numberOfItemInSection = [self.collectionView numberOfItemsInSection:0];//第0组，Item个数
    
    //设置item中心位置
    attributes.center = CGPointMake(collectionViewWidth * 0.5 + currentX, self.collectionView.frame.size.height * 0.5);//屏幕中心
    //设置item尺寸
    attributes.size = CGSizeMake(100.0f, 150.0f);//与cell的尺寸相同，以保证显示内容完全
    
    //设置旋转
    CATransform3D transform = CATransform3DIdentity;//默认（1000，0100，0010，0001）
    transform.m34 = -1.0f / 800.0f;//设置透视效果
    
    //设置旋转角度（总共占有2π）求出每个的旋转角
    CGFloat angle = (indexPath.item - currentX / collectionViewWidth + 1)/ numberOfItemInSection * arc;// 当前 * 360 / 总个数
    
    //设置平移距离（旋转后相对位置会变化，通过平移Z轴来完全显示内容）
    CGFloat radius = attributes.size.width / 2 /tanf(arc / 2.0f / numberOfItemInSection);//固定平移距离,使得每个图片的无缝衔接，若要有缝隙，可以适当增大//沿着X轴翻转与height相关，沿着Y轴翻转与width相关,平移距离，实质与法向量方向相关//（平均每个允许平移距离的相对上一个的最大平移距离）
    
    transform = CATransform3DRotate(transform, angle * 1, 0.0f, 1.0f, 0.0f);//旋转X,Y,Z,近大远小效果，实现突起与缩小，可以加大旋转的弧度
    transform = CATransform3DTranslate(transform, 0.0f, 0.0f, radius + 30);//平移，上一次的位置，X增加，Y增加，Z增加：实质为改变图层相对屏幕位置（可以理解为图层的层次）
    
    //    transform = CATransform3DTranslate(transform, 0, 0, 300);//
    
    attributes.transform3D = transform;
    
    return attributes;
}

#pragma mark - 返回具体位置的Item的布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //    NSLog(@"layoutAttributesForElementsInRect:%@",NSStringFromCGRect(rect));//默认1334 * 667
    
    //首先获取父类方法中所有位置的属性数组
    NSArray *attributesArray = nil;
    
    //    [super layoutAttributesForElementsInRect:rect];
    //    if (attributesArray.count > 0) {
    //
    //        return attributesArray;//若已经用父类已确定的布局，则直接返回
    //    }
    //否则调用自己设置的布局
    NSMutableArray *mAttributesArray = [NSMutableArray new];
    
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i ++) {//取得每个Item的布局属性
        
        //取得item的位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //取得相应位置（第0组），所有Item的属性
        [mAttributesArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }//当然可以通过嵌套for循环获取所有的item位置的属性
    
    attributesArray = mAttributesArray;
    
    return attributesArray;
}

/*
 
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
 
 */

@end
