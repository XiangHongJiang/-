//
//  XHDDOnlineChatContactsTableView.m
//  DDOnline
//
//  Created by qianfeng on 16/3/15.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineChatContactsTableView.h"
#import "EMSDKFull.h"
#import "XHDDOnlineChatDetailController.h"
#import "XHButton.h"
#import "UIView+Border.h"

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
/** *  每组状态 */
@property (nonatomic, strong)NSMutableArray *sectionState;
/** *  分组名 */
@property (nonatomic, copy) NSArray *sectionNameArray;
/** *  要删除的服务器数据 */
@property (nonatomic, strong) NSMutableArray *needDeleteData;

@end

@implementation XHDDOnlineChatContactsTableView

- (NSMutableArray *)needDeleteData{

    if (_needDeleteData == nil) {
        
        _needDeleteData = [NSMutableArray new];
    }
    return _needDeleteData;
}
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
    
    contactsTableView.sectionHeaderHeight = 45;
    
    contactsTableView.delegate = contactsTableView;
    contactsTableView.dataSource = contactsTableView;
    
//    contactsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    self.tableFooterView = [[UIView alloc] init];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XHDDOnlineChatDetailController *chatCtrl = [[XHDDOnlineChatDetailController alloc] init];
    
    chatCtrl.navigationItem.title = self.contactsArray[indexPath.section][indexPath.row];
    [self.viewController.navigationController pushViewController:chatCtrl animated:YES];
}
#pragma mark - 返回组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, 45)];
    
    [headView drawLineWithColor:[UIColor grayColor] locate:WLocateBottom andPedding:0];
    
    //1一个可点击的Btn
    XHButton *headBtn = [[XHButton alloc] initWithFrame:CGRectMake(0, 5, JScreenWidth, 40)];
    
    [headBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    
    headBtn.tag = section + 1;
    [headBtn setTitle:self.sectionNameArray[section] forState:UIControlStateNormal];
    headBtn.imageView.contentMode = UIViewContentModeCenter;
    headBtn.imageView.clipsToBounds = NO;

    //设置图标旋转, 区分打开与关闭状态
    if ([_sectionState[section] boolValue] == NO) {

        headBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
      
    }else{
        headBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }

    [headView addSubview:headBtn];
    return headView;
}
- (void)headClick:(UIButton *)headBtn{
    
    BOOL ret = [self.sectionState[headBtn.tag - 1] boolValue];
    
    [self.sectionState replaceObjectAtIndex:headBtn.tag - 1 withObject:@(!ret)];
    [self reloadData];
}
#pragma mark - 删除相关
- (void)deleteContacts{
    
    [self.needDeleteData removeAllObjects];
    
    NSArray *indexPaths = self.indexPathsForSelectedRows;
    //这个数组里的顺序是按照选中顺序排列的
 
    //要先对数组进行排序 //返回一个排序好的数组, 原数组不变
    NSArray *orderedArray = [indexPaths sortedArrayUsingSelector:@selector(compare:)];
    
    //获取当前数据源
    NSMutableArray *leftDataArray = [NSMutableArray arrayWithArray:self.contactsArray];

    //先删除数据源
    for (NSInteger i = orderedArray.count - 1; i >= 0; i --) {//每次先删除最后一个, 防止越界删除
        
        NSIndexPath *indexPath = orderedArray[i];
        
        NSString *deleteName = leftDataArray[indexPath.section][indexPath.row];
        
        [self.needDeleteData addObject:deleteName];
        
        //找到选中行
        //1.从数据源中删除
        [leftDataArray[indexPath.section] removeObjectAtIndex:indexPath.row];

    }
    
    _tempDataArray = leftDataArray;
    
    //刷新tableView
    [self reloadData];
    self.enterEditting = NO;

    [self deleteFromNet:orderedArray];

}
#pragma mark -服务器删除好友
- (void)deleteFromNet:(NSArray *)indexPaths{

    //如果删除成功：则不用刷新tableView了，因为已经刷新过
    dispatch_async(JGlobalQueue, ^{
       
        BOOL haveDelFail = NO;
        
        for (NSInteger i = indexPaths.count - 1; i >= 0; i --) {//每次先删除最后一个, 防止越界删除
            
            NSIndexPath *indexPath = indexPaths[i];
          
            //找到删除的名字
            NSString *userName = self.needDeleteData[indexPaths.count - i - 1];
            
            //删除
            if (indexPath.section == 1) {//黑名单删除
                
                EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:userName];
                if (!error) {
                    NSLog(@"删除成功");
                }
                else{
                    
                    haveDelFail = YES;
                    JLog(@"删除失败");
                }
                
            }
            else{//好友删除
                    // 删除好友
                    EMError *error = [[EMClient sharedClient].contactManager deleteContact:userName];
                    if (!error) {
                        NSLog(@"删除成功");
                    }
                    else{
                    
                        haveDelFail = YES;
                        JLog(@"删除失败");
                    }
                
                }
        }
        
        //所有的删除都执行完毕后判定是否有删除没成功的，如果有没成功的，则从服务器重新刷新拉取
        if (haveDelFail) {

            //1.到主线程所在的队列
            dispatch_async(dispatch_get_main_queue(), ^{
   
                [self.mj_header beginRefreshing];
                
            });

        }
        
    });

}

@end
