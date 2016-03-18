//
//  XHDDOnlineFunPlaySearchController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/13.
//  Copyright (c) 2016年 JXHDev. All rights reserved.
//

/*
 
 + (id)getSeachParameters:(NSDictionary*)dic CompletionHandler:(void(^)(id responseObj, NSError *error))complete{
 //http://api.bilibili.com/search?_device=android&_hwid=831fc7511fa9aff5&appkey=85eb6835b0a1034e&bangumi_num=1&build=408005&keyword=%E5%B9%B2%E7%89%A9%E5%A6%B9&main_ver=v3&page=1&pagesize=20&platform=android&search_type=all&source_type=0&special_num=1&topic_num=1&upuser_num=1&sign=fb67d8906d97af4f4cdfa29a143df3d6
 NSMutableDictionary* mdic = [dic mutableCopy];
 mdic[@"_device"] = @"android";
 mdic[@"_hwid"] = @"831fc7511fa9aff5";
 mdic[@"appkey"] = APPKEY;
 mdic[@"bangumi_num"] = @"1";
 mdic[@"build"] = @"408005";
 mdic[@"main_ver"] = @"v3";
 mdic[@"page"] = @"1";
 mdic[@"pagesize"] = @"20";
 mdic[@"platform"] = @"android";
 mdic[@"search_type"] = @"all";
 mdic[@"source_type"] = @"0";
 mdic[@"special_num"] = @"1";
 mdic[@"topic_num"] = @"1";
 mdic[@"upuser_num"] = @"1";
 NSString* basePath = [mdic appendGetSortParameterWithSignWithBasePath: @"http://api.bilibili.cn/search?"];
 return [self Get:basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
 complete([SearchModel mj_objectWithKeyValues: [NSJSONSerialization json2DicWithData: responseObj][@"result"]],error);
 }];
 }

 
 //画江湖
 http://api.bilibili.com/suggest?_device=android&_hwid=bcbfd479c4762248&appkey=c1b107428d337928&bangumi_acc_num=1&bangumi_num=0&build=412001&func=suggest&main_ver=v3&platform=android&special_acc_num=1&special_num=0&suggest_type=accurate&term=%E7%94%BB%E6%B1%9F%E6%B9%96%E4%B9%8B%20%E7%81%B5%E4%B8%BB&topic_acc_num=1&topic_num=0&upuser_acc_num=1&upuser_num=0&sign=7c1130e157d2d973a5c91642268d069e
 http://api.bilibili.com/search?_device=android&_hwid=bcbfd479c4762248&appkey=c1b107428d337928&build=412001&keyword=%E7%94%BB%E6%B1%9F%E6%B9%96%E4%B9%8B%20%E7%81%B5%E4%B8%BB&main_ver=v3&page=1&pagesize=20&platform=android&search_type=all&source_type=0&sign=c9d196e894a93f733cba5bbc0205b59c
 
 
 //黑子3
 http://api.bilibili.com/suggest?_device=android&_hwid=bcbfd479c4762248&appkey=c1b107428d337928&bangumi_acc_num=1&bangumi_num=0&build=412001&func=suggest&main_ver=v3&platform=android&special_acc_num=1&special_num=0&suggest_type=accurate&term=%E9%BB%91%E5%AD%90%E7%9A%84%E7%AF%AE%E7%90%83%20%E7%AC%AC%E4%B8%89%E5%AD%A3&topic_acc_num=1&topic_num=0&upuser_acc_num=1&upuser_num=0&sign=27c63cfe104e33eb3b93ef83b066d97a
 http://api.bilibili.com/search?_device=android&_hwid=bcbfd479c4762248&appkey=c1b107428d337928&build=412001&keyword=%E9%BB%91%E5%AD%90%E7%9A%84%E7%AF%AE%E7%90%83%20%E7%AC%AC%E4%B8%89%E5%AD%A3&main_ver=v3&page=1&pagesize=20&platform=android&search_type=all&source_type=0&sign=7e25c6695bec573a9525de067671961a
 
 
 //追忆潸然
 http://api.bilibili.com/suggest?_device=android&_hwid=bcbfd479c4762248&appkey=c1b107428d337928&bangumi_acc_num=1&bangumi_num=0&build=412001&func=suggest&main_ver=v3&platform=android&special_acc_num=1&special_num=0&suggest_type=accurate&term=%E8%BF%BD%E5%BF%86%E6%BD%B8%E7%84%B6&topic_acc_num=1&topic_num=0&upuser_acc_num=1&upuser_num=0&sign=3a6eee3f21a8c69d6508363798e5481a
 http://api.bilibili.com/search?_device=android&_hwid=bcbfd479c4762248&appkey=c1b107428d337928&build=412001&keyword=%E8%BF%BD%E5%BF%86%E6%BD%B8%E7%84%B6&main_ver=v3&page=1&pagesize=20&platform=android&search_type=all&source_type=0&sign=a7c2d32b504f691714258dba1c7d6623
 
 UP主
 http://api.bilibili.com/search?_device=android&_hwid=bcbfd479c4762248&appkey=c1b107428d337928&build=412001&keyword=%E6%8A%97%E9%9F%A9%E4%B8%AD%E5%B9%B4%E4%BA%BA&main_ver=v3&page=1&pagesize=20&platform=android&search_type=upuser&source_type=0&sign=3e9a9b05057daabf60a79e8f64c3c92d
 
 
 
 
 */

#import "XHDDOnlineFunPlaySearchController.h"

#import "XHSearchCtrlView.h"
#import "XHSoundInputView.h"

@interface XHDDOnlineFunPlaySearchController ()<UISearchBarDelegate,SearchCtrlViewDelegate>
{
    __weak XHSoundInputView *_soundInputView;
    
}
/** *  搜索栏 */
@property (nonatomic, weak) UISearchBar * searchBar;
/** *  热门搜索数据源 */
@property (nonatomic, copy) NSArray *hotSearch;
/** *  历史搜索数据源 */
@property (nonatomic, strong) NSMutableArray *historySearch;
/** *  主视图 */
@property (nonatomic, weak) XHSearchCtrlView *searchCtrlView;
/** *  语音输入视图 */
@property (nonatomic, weak) XHSoundInputView *soundInputView;

@end

@implementation XHDDOnlineFunPlaySearchController
{
    NSInteger _index;
}
#pragma mark - lazyLoad
- (NSArray *)hotSearch{
    
    if (_hotSearch == nil) {
        
        _hotSearch = @[@"黑子的篮球", @"K", @"魔法少女小圆", @"亚人", @"弑神者", @"画江湖之不良人",@"牙狼——红莲之月",@"重装武器",@"南方公园"];
    }
    
    return _hotSearch;
}
- (NSArray *)historySearch{
    
    if (_historySearch == nil) {
        
        //获取沙盒
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *history = [ud objectForKey:@"historySearch"];//@[@"来点啥", @"来点水果", @"来点蔬菜", @"据说唐僧肉很好吃", @"盐汽水"];
        
        _historySearch = [NSMutableArray arrayWithArray:history];
        
        
    }
    return _historySearch;
    
}
/**语音输入视图*/
- (XHSoundInputView *)soundInputView{
    
    if (_soundInputView == nil) {
        
        //create
        XHSoundInputView *soundInputView = [XHSoundInputView soundInputView];
        //set
        _soundInputView = soundInputView;
        soundInputView.frame = CGRectMake(0, 0, JScreenWidth, JScreenHeight);
        //add
        [self.view addSubview:soundInputView];
        [self.view sendSubviewToBack:soundInputView];
    }
    
    return _soundInputView;
}

- (void)loadView{
    [super loadView];
    
    //1.添加搜索按钮
    [self setupSearchBtn];
    //2.创建searchBar
    [self setupSearchBar];
    //3.创建searchCtrlView
    [self setupSearchCtrlView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.translucent = NO;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _index++;
    if (_index == 1) {
        
    }else
    {
        self.searchCtrlView.frame = CGRectMake(0, 64, JScreenWidth, JScreenHeight);
    }
    
}
#pragma mark - setupUI
/**搜索栏*/
- (void)setupSearchBar{
    //creat
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 100, 44)];
    //set
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"搜索你感兴趣的";
    self.searchBar = searchBar;
    searchBar.returnKeyType = UIReturnKeyDone;
    
    //add
    self.navigationItem.titleView = searchBar;
    
}
/**主视图*/
- (void)setupSearchCtrlView{
    //create
    XHSearchCtrlView *searchCtrlView = [XHSearchCtrlView searchCtrlView];
    //set
    searchCtrlView.delegate = self;
    self.searchCtrlView = searchCtrlView;
    searchCtrlView.historySearchArray = self.historySearch;
    searchCtrlView.hotSearchArray = self.hotSearch;
    //add
    [self.view addSubview:searchCtrlView];
    self.searchCtrlView.frame = CGRectMake(0, 0, JScreenWidth, JScreenHeight);

    //添加了主搜索视图后才成为第一响应，防止键盘监听失效
    [self.searchBar becomeFirstResponder];
    
}
/**搜索按钮*/
- (void)setupSearchBtn{

    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = searchBtn;
}
#pragma mark - UISearchBarDelegate
/**开始编辑*/
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    //移除语音输入视图
    if (_soundInputView) {
        
        [_soundInputView removeFromSuperview];
    }
}
/**点击了键盘搜索*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    [searchBar resignFirstResponder];
    
}
/**点击了搜索按钮*/
- (void)searchAction{
#warning 搜索内容
    
    if (self.searchBar.text.length >0) {
        
        JLog(@"搜索%@",self.searchBar.text);
    }
    
    //推出搜索结果控制器。pop当前控制器
    

}
/**点击了取消*/
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark -SearchCtrlViewDelegate
/**点击了语音输入*/
- (void)searchCtrlViewDidSelectedSoundInput:(XHSearchCtrlView *)searchlView{
    //提在最前
    [self.searchBar resignFirstResponder];
    [self.view bringSubviewToFront:self.soundInputView];

    __weak typeof(self) weakSelf = self;
    
    //回调语音bolck
    self.soundInputView.detectSoundSucceedBlock = ^(NSString *soundString){
        
        if (soundString.length > 0) {//如果搜索到语音
            
            [weakSelf.soundInputView removeFromSuperview];
            [weakSelf.searchBar becomeFirstResponder];

            //先移除原来
            [_historySearch removeObject:soundString];
            [_historySearch insertObject:soundString atIndex:0];
            weakSelf.searchCtrlView.historySearchArray = _historySearch;
            
           weakSelf.searchBar.text = soundString;
        }
        

        
    };
}
/**点击了热门搜索*/
- (void)searchCtrlView:(XHSearchCtrlView *)searchlView didSelectedHotSearch:(NSString *)hotSearchName{
    //插入为历史搜索第一条
    //先移除原来
    [_historySearch removeObject:hotSearchName];
    [_historySearch insertObject:hotSearchName atIndex:0];
    self.searchCtrlView.historySearchArray = _historySearch;
    
    self.searchBar.text = hotSearchName;
    
    JLog(@"点击了热门搜索%@",hotSearchName);
}
/**点击了历史搜索*/
- (void)searchCtrlView:(XHSearchCtrlView *)searchlView didSelectedHistorySearch:(NSString *)historySearchName{
    self.searchBar.text = historySearchName;
}
/**点击了清除历史*/
- (void)searchCtrlViewDidSelectedClearHistorySearch:(XHSearchCtrlView *)searchView{
    
    [_historySearch removeAllObjects];
}
/**视图即将消失：数据存沙盒*/
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:NO];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud  setObject:_historySearch forKey:@"historySearch"];
    [ud synchronize];
    self.navigationController.navigationBar.translucent = YES;
    
}
@end
