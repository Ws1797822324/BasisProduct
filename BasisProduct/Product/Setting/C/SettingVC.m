//
//  SettingVC.m
//  Product
//
//  Created by Sen wang on 2017/7/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()

@property (nonatomic ,copy) NSArray *nameArr;
/// 缓存
@property (nonatomic ,copy) NSString *cacheSize;


@end

@implementation SettingVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar resetLine];
   
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];

    kViewRadius(self.singOut,4);
    
    self.title = @"设置";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    _nameArr = @[@"修改个人资料",@"更换手机号码",@"修改支付密码",@"修改登录密码",@"人脸识别",@"声纹识别",@"清除缓存",@"语音设置",@"意见反馈",@"关于多吃菜"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SettingCell class]) bundle:nil] forCellReuseIdentifier:@"SettingCellID"];
    [XXHelper deleteExtraCellLine:_tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCellID" forIndexPath:indexPath];
    cell.nameLabel.text = _nameArr[indexPath.row];
    cell.switchView.tag = indexPath.row;
    if (indexPath.row == 4 || indexPath.row == 5) {
        cell.switchView.hidden = NO;
        cell.rightImg.hidden = YES;
        cell.cacheLabel.hidden = YES;
    } else {
        cell.switchView.hidden = YES;
        cell.rightImg.hidden = NO;
        cell.cacheLabel.hidden = YES;


    }
    if (indexPath.row == 6) {
        cell.cacheLabel.hidden = NO;
        cell.switchView.hidden = YES;
        cell.rightImg.hidden = YES;
        [self readCacheSize];
        cell.cacheLabel.text =  [NSString stringWithFormat:@"%@ M",[XXHelper positiveFormat:_cacheSize]];
        
        NSLog(@"%@",[XXHelper positiveFormat:_cacheSize]);
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 6) {

    NSArray * items = @[MMItemMake(@"确定", MMItemTypeNormal, ^(NSInteger index) {
        [self clearFile];

    }), MMItemMake(@"取消", MMItemTypeHighlight, ^(NSInteger index) {
        
    })];

    MMAlertView *alertView = [[MMAlertView alloc]initWithTitle:@"清除缓存" detail:@"" items:items];
    
    [alertView show];
    
    }
}

#pragma mark - 计算缓存
-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
//    [cachePath floatValue]< 0.001 ? cachePath = @"0.01" : cachePath;
    _cacheSize = cachePath;
    NSLog(@" kkk   %@",cachePath);

    return [ self folderSizeAtPath :cachePath];
}

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}
// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}
// MARK: ------ 清除缓存 ------
- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
    //读取缓存大小
    float cacheSize = [self readCacheSize] *1024;
    self.cacheSize = [NSString stringWithFormat:@"%.2fKB",cacheSize];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:6 inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
   
}
// MARK: ------ 退出登录操作 ------
- (IBAction)singOutAction:(UIButton *)sender {
    
    NSLog(@"退出登录Action");
}
@end
