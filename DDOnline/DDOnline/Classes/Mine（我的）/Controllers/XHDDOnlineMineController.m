//
//  XHDDOnlineMineController.m
//  DDOnline
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 JXHDev. All rights reserved.
//

#import "XHDDOnlineMineController.h"
#import "XHDDOnlineSignInController.h"
#import "EMSDKFull.h"
#import "XHDDOnlineMineSkinController.h"
#import "XHDDOnlineSliderController.h"
#import "XHDDOnlineSettingController.h"

@interface XHDDOnlineMineController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic)  UIButton *headerBtn;

@property (weak, nonatomic)  UILabel *nameLabel;
@property (weak, nonatomic)  UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  功能列表名
 */
@property (nonatomic, copy) NSArray *functionNameArray;
@end

@implementation XHDDOnlineMineController
- (NSArray *)functionNameArray{
    
    if (_functionNameArray == nil) {
        
        _functionNameArray = @[@"我的下载",@"我的收藏",@"我的皮肤",@"设置"];
    }
    
    return _functionNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //1.添加表头
    [self setupTableHeaderView];
    
    //2.监听登录成功状态，改变头像和名字
    [self configNotifiCationCenter];
    
    
    //3.监听皮肤背景更换
    [self changeSkin];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - 添加表头
- (void)setupTableHeaderView{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, JScreenHeight * 0.3)];
    self.tableView.tableHeaderView = headerView;
    
    UIImageView *headerViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JScreenWidth, JScreenHeight * 0.3)];
    [headerView addSubview:headerViewBG];
//    headerViewBG.image = [UIImage imageNamed:@"headerBG"];
    self.backGroundImageView = headerViewBG;
    
    UIButton *headerBtn = [XHUtils creatBtnWithFrame:CGRectMake(20, JScreenHeight * 0.3 - 120, 100, 100) title:@"" target:self action:@selector(clickHeadBtn:)];
    [headerView addSubview:headerBtn];
    self.headerBtn = headerBtn;
    headerBtn.layer.cornerRadius = self.headerBtn.frame.size.height * 0.5;
    headerBtn.layer.masksToBounds = YES;
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"default－portrait"] forState:UIControlStateNormal];
    
    UILabel *nameLabel = [XHUtils createLabelFrame:CGRectMake(140, JScreenHeight * 0.3 - 60, 150, 20) text:@"点击头像登录" font:[UIFont systemFontOfSize:15]];
    self.nameLabel = nameLabel;
    [headerView addSubview:nameLabel];
    
}

#pragma mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.functionNameArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.functionNameArray[indexPath.section];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *ctrl = nil;
    //创建
    switch (indexPath.section) {
        case 0://我的下载
            ctrl = nil;
            break;
            
            case 1://我的收藏
            break;
            
            case 2://我的皮肤
             ctrl = [[XHDDOnlineMineSkinController alloc] init];
            break;
            
            case 3://
            ctrl = [[XHDDOnlineSettingController alloc] init];
            break;
            
        default:
            break;
    }
    
    //推出
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - viewWillApper
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - tableView Delegate
- (void)clickHeadBtn:(UIButton *)headerBtn {
    
    //判断是否登录，如果登录进入相册可更换头像，否则进入登录界面
    
    if([EMClient sharedClient].currentUsername.length > 0)
    {//已登录，设置头像,相册,相机
        
    
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"设置头像" otherButtonTitles:@"从图库",@"从相册",@"从相机",nil];
        
        [actionSheet showInView:self.view];
    }
    else {//未登录，
        
        [self.navigationController pushViewController:[[XHDDOnlineSignInController alloc] init] animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
#pragma mark - 监听登录
- (void)configNotifiCationCenter{
    //登录成功监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed) name:@"loginSucceed" object:nil];
    
    //更换皮肤通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSkin) name:@"changeSkin" object:nil];
}
//登录成功
- (void)loginSucceed{
     self.nameLabel.text = [EMClient sharedClient].currentUsername;
    //解归档
    //存储路径
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"userHeaderImage"]];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data == nil) {
        [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"selfHeaderImage"] forState:UIControlStateNormal];
        
        return;       
    }
    UIImage *userHeaderImage =[UIImage imageWithData:data];
    
    //设置头像
    [self.headerBtn setBackgroundImage:userHeaderImage forState:UIControlStateNormal];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - actionSheet Delegate//更换头像
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    UIImagePickerController *imagePickCtrl = [[UIImagePickerController alloc] init];
    imagePickCtrl.allowsEditing = YES;
    imagePickCtrl.delegate = self;
    
    //    UIImagePickerControllerSourceTypePhotoLibrary,
    //    UIImagePickerControllerSourceTypeCamera,
    //    UIImagePickerControllerSourceTypeSavedPhotosAlbum
    if (buttonIndex == 1) {
           imagePickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if (buttonIndex == 2)
    {
                   imagePickCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    else if (buttonIndex == 3){
        imagePickCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
           return;
    }
    [self presentViewController:imagePickCtrl animated:YES completion:^{
        
    }];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *selectedImage = info[@"UIImagePickerControllerEditedImage"];
   
    //压缩图片
    UIImage *image = [XHUtils imageWithImageSimple:selectedImage scaledToSize:CGSizeMake(100, 100)];
   
    //设置头像
    [self.headerBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    //设置侧边栏操作
    XHDDOnlineSliderController *slider = (XHDDOnlineSliderController *)self.sideMenuViewController.leftMenuViewController;
    slider.headerImageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        dispatch_async(JGlobalQueue, ^{
            //获取二进制
            NSData *imageData = UIImagePNGRepresentation(image);
            
            //存储路径
            NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            
            NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"userHeaderImage"]];
            
            //存储
            if ([imageData writeToFile:filePath atomically:YES]) {
                JLog(@"存储成功");
            }else{
                
                JLog(@"存储失败");
            }

        });
    }];
    
}
#pragma mark - 更换皮肤
- (void)changeSkin{

    self.backGroundImageView.image = nil;
    
    NSString *addressPre =  [[NSUserDefaults standardUserDefaults] objectForKey:@"skinAddress"];
    
    NSString *skinPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/themeColor.plist",addressPre] ofType:nil];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:skinPath];
    
    NSArray *rgbArray = [dict[@"navigationColor"] componentsSeparatedByString:@","];
    
    self.view.backgroundColor = self.backGroundImageView.backgroundColor = JColorRGB([rgbArray[0] floatValue], [rgbArray[1]floatValue], [rgbArray[2]floatValue]);
    
}

@end
