//
//  SettingVC.m
//  Product
//
//  Created by Sen wang on 2017/7/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingVC.h"

#import "SDImageCache.h"

@interface SettingVC ()

@property (nonatomic, copy) NSArray *nameArr;


@end

@implementation SettingVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    kViewRadius(self.singOut, 4);
    
    self.title = @"设置";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    _nameArr = @[
                 @"修改个人资料", @"更换手机号码", @"修改支付密码", @"修改登录密码", @"人脸识别",
                 @"声纹识别", @"清除缓存", @"语音设置", @"意见反馈", @"关于多吃菜"
                 ];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SettingCell class]) bundle:nil]
     forCellReuseIdentifier:@"SettingCellID"];
    [XXHelper deleteExtraCellLine:_tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        
        NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
        //
        NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
        
        cell.cacheLabel.text = [NSString stringWithFormat:@"%@", currentVolum];
        
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 6) {
        
        NSArray *items = @[
                           MMItemMake(@"确定", MMItemTypeNormal,
                                      ^(NSInteger index){
                                          
                                          [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                                              
                                              //定时器 2s 后显示提示语
                                              [[RACScheduler mainThreadScheduler]afterDelay:2.f schedule:^{
                                                  [XXProgressHUD showSuccess:@"清除缓存成功"];
                                                  
                                              }];
                                          }];
                                          
                                      }),
                           MMItemMake(@"取消", MMItemTypeHighlight,
                                      ^(NSInteger index){
                                          
                                      })
                           ];
        
        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"清除缓存" detail:@"" items:items];
        
        [alertView show];
    }
}
#pragma mark - 计算出图片缓存的大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}


// MARK: ------ 退出登录操作 ------
- (IBAction)singOutAction:(UIButton *)sender {
    
    NSLog(@"退出登录Action");
}
@end
