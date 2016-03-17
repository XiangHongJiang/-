//
//  XHDDOnlineChatContactsTableView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/15.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatContactsTableView.h"

@interface XHDDOnlineChatContactsTableView()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    /**
     *  搜索相关
     */
    UISearchBar *_searchBar;
    NSMutableArray *_searchResultsArray;
    /**
     *  临时数据源
     */
    NSArray *_tempDataArray;
}
@property (nonatomic, strong)NSMutableArray *sectionState;
/** *  分组名 */
@property (nonatomic, copy) NSArray *sectionNameArray;

@end

@implementation XHDDOnlineChatContactsTableView
- (NSMutableArray *)sectionState{

    if (_sectionState == nil) {
        
        _sectionState = [NSMutableArray new];
    }
    return _sectionState;
}
- (NSArray *)sectionNameArray{

    if (_sectionNameArray == nil) {
        
        _sectionNameArray = @[@"我的好友",@"黑名单"];
    }
    
    return _sectionNameArray;
}
#pragma mark - 快速建立视图
+ (instancetype)chatContactsTableView{
    
    XHDDOnlineChatContactsTableView *contactsTableView = [[XHDDOnlineChatContactsTableView alloc] initWithFrame:CGRectMake(JScreenWidth, 0, JScreenWidth, JScreenHeight - JTopSpace - JTabBarHeight) style:UITableViewStylePlain];
    
    contactsTableView.delegate = contactsTableView;
    contactsTableView.dataSource = contactsTableView;
    
    contactsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加搜索
    [contactsTableView addSearchBar];
    
    return contactsTableView;
}
#pragma mark - 添加搜索栏
- (void)addSearchBar{
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 10, JScreenWidth, 40)];
    _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.showsCancelButton = YES;

    _searchBar.delegate = self;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, 50)];
    view.backgroundColor = JColorLightGray;
    
    [view addSubview:_searchBar];
    
    self.tableHeaderView = view;
    //搜索数组
    _searchResultsArray = [NSMutableArray new];
    
}
#pragma mark - 搜索相关
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    if ([searchBar.text isEqualToString:@""]) {
        
        _tempDataArray = self.contactsArray;
    }
    else{
        //搜索数组先移除原先数据
        [_searchResultsArray  removeAllObjects];
        
        //开始查找
        for (NSArray *tempArray in self.contactsArray) {
            
            NSMutableArray *mArray = [NSMutableArray new];
            
            for (NSString *name in tempArray) {//查找每组里面是否有
                
                NSRange range = [name rangeOfString:searchBar.text];
                
                if (range.location != NSNotFound) {//如果找到了
                    
                    [mArray addObject:name];
                }
            }
            [_searchResultsArray addObject:mArray];
         }
        
        //查找结束赋值
        _tempDataArray = _searchResultsArray;
    }
    
    //刷新数据
    [self reloadData];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
#pragma mark - setter and getter
- (void)setContactsArray:(NSArray *)contactsArray{
    
    _contactsArray = contactsArray;
    //设置缓存池数据源
    _tempDataArray = contactsArray;
    
    for (int i = 0; i < contactsArray.count; i ++) {
        
        [self.sectionState addObject:@(NO)];
    }
    
    //刷新数据
    [self reloadData];
}
- (void)setEnterEditting:(BOOL)enterEditting{//进入多选状态

    _enterEditting = enterEditting;
    self.allowsMultipleSelectionDuringEditing = enterEditting;
    self.editing = enterEditting;
}
- (void)setDeleteAction:(BOOL)deleteAction{

    _deleteAction = deleteAction;
    [self deleteContacts];
}
#pragma mark - 联系人tableView相关代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tempDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_tempDataArray != _searchResultsArray) {//如果不在搜索状态，判断是否展开，在搜索状态，直接返回个数
       
        //判断是否展开
        if ([self.sectionState[section] boolValue]== YES) {//判断是否展开
            
            return 0;
        }
    }
    
    return [_tempDataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"contactsCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _tempDataArray[indexPath.section][indexPath.row];
    
    return cell;
}
#pragma mark - 返回组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, 50)];
    
    //1一个可点击的Btn
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.frame = CGRectMake(0, 0, JScreenWidth, 30);
    
    headBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    [headBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    
    headBtn.tag = section + 1;
    [headBtn setTitle:self.sectionNameArray[section] forState:UIControlStateNormal];
    [headBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    headBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [headBtn setImage:[UIImage imageNamed:@"tab_c2"] forState:UIControlStateNormal];

    //设置图标旋转, 区分打开与关闭状态
//    if ([_sectionState[section] boolValue] == NO) {
//        headBtn.imageView.transform = CGAffineTransformMakeRotation(M_2_PI);
//    }else{
//        headBtn.imageView.transform = CGAffineTransformMakeRotation(-M_2_PI);
//    }
    
    [headView addSubview:headBtn];
    
    return headView;
    
}
- (void)headClick:(UIButton *)headBtn{
    
    BOOL ret = [self.sectionState[headBtn.tag - 1] boolValue];
    
    [self.sectionState replaceObjectAtIndex:headBtn.tag - 1 withObject:@(!ret)];
    [self reloadData];
}
#pragma mark - 组头与表头高度的设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
#pragma mark - 删除相关
- (void)deleteContacts{
    
    NSArray *indexPaths = self.indexPathsForSelectedRows;
    //这个数组里的顺序是按照选中顺序排列的
    
    //要先对数组进行排序 //返回一个排序好的数组, 原数组不变
    NSArray *orderedArray = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
    
    //获取当前数据源
    NSMutableArray *dataSource = [NSMutableArray arrayWithArray:self.contactsArray];
    
    //先删除数据源
    for (NSInteger i = orderedArray.count - 1; i >= 0; i --) {//每次先删除最后一个, 防止越界删除
        
        NSIndexPath *indexPath = indexPaths[i];
        //找到选中行
        
        //从数据源中删除
        [dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        
    }
    
    _tempDataArray = dataSource;
    //刷新tableView
    [self reloadData];
    
    self.enterEditting = NO;
    
}
@end
