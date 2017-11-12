//
//  XXViewController.m
//  Product
//
//  Created by Sen wang on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXViewController.h"
#import "MMPopupViewDemoVC.h"


#import "ShoppingOrderVC.h"

#import "SpreadDropMenu.h"

@interface XXViewController () <UIImagePickerControllerDelegate, TZImagePickerControllerDelegate, UIAlertViewDelegate,UIActionSheetDelegate, UINavigationControllerDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,LKNotificationDelegate> {
}
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;



@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, assign) BOOL allowCrop; // 是否允许裁剪
@property (weak, nonatomic) IBOutlet UIButton *xxButton;

@property (weak, nonatomic) IBOutlet UIView *xxView;
    @property (weak, nonatomic) IBOutlet UIButton *sanfang;

- (IBAction)tnchu:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@end

@implementation XXViewController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem =
                [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[ [TZImagePickerController class] ]];
            BarItem =
                [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[ [UIImagePickerController class] ]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (IBAction)pushAction:(UIButton *)sender {
}

- (void)viewDidLoad {
    
    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;

    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];


    self.testLabel.text = kLocalizedString(@"abc");
    self.title = @"首页";
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self.navigationController.tabBarItem setBadgeValue:@"3"];
}


- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 || indexPath.column == 1) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.row];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 && indexPath.item >= 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.item];
    }
    return nil;
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column < 2) {
        return [@(arc4random()%1000) stringValue];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    return [@(arc4random()%1000) stringValue];
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            return self.cates.count;
        } else if (row == 2){
            return self.movices.count;
        } else if (row == 3){
            return self.hostels.count;
        }
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return self.cates[indexPath.item];
        } else if (indexPath.row == 2){
            return self.movices[indexPath.item];
        } else if (indexPath.row == 3){
            return self.hostels[indexPath.item];
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏下那条线
    //    [self.navigationController.navigationBar hiddenLine];
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)xxBttton:(UIButton *)sender {

    [self pushImagePickerController];
}
#pragma mark - TZImagePickerController

- (void)pushImagePickerController {

    // 最多选1   一排方4个  可以改
    TZImagePickerController *imagePickerVc =
        [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];

    // 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = false;

    imagePickerVc.allowTakePicture = true; // 在内部显示拍照按钮

    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    imagePickerVc.navigationBar.barTintColor = [UIColor brownColor];
    imagePickerVc.navigationBar.translucent = NO;

    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图/DIF
    imagePickerVc.allowPickingVideo = false;
    imagePickerVc.allowPickingImage = true;
    imagePickerVc.allowPickingOriginalPhoto = false; // 选原图不能裁剪
    imagePickerVc.allowPickingGif = false;

    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = true;

    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;

    // 单选模式下允许裁剪
    imagePickerVc.allowCrop = true;
    // 圆形裁剪框
    imagePickerVc.needCircleCrop = true;
    // 圆形裁剪框半径大小
    imagePickerVc.circleCropRadius = 135;
/*
 [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
 cropView.layer.borderColor = [UIColor redColor].CGColor;
 cropView.layer.borderWidth = 2.0;
 }];*/
// 预览
// imagePickerVc.allowPreview = NO;

#pragma mark - 到这里为止

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc
        setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [_xxButton setBackgroundImage:photos[0] forState:UIControlStateNormal];

            NSDictionary *dict = @{
                @"content" : @"ooooooooooooooooooooo",
                @"id" : @"48",
                //                                @"pic" : @""
            };

            [XXNetWorkManager uploadImageWithOperations:dict
                withImageArray:photos
                withtargetWidth:100
                withUrlString:@"http://119.23.141.210:10030/users/opinion"
                withSuccessBlock:^(id objc) {
                    NSLog(@"1111111 %@", objc);
                }
                withFailurBlock:^(id error) {
                    NSLog(@"22222%@", error);
                }
                withUpLoadProgress:^(float uploadProgress){

                }];

        }];

    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (IBAction)push:(UIButton *)sender {
    
    MMPopupViewDemoVC *vc = [MMPopupViewDemoVC new];
    vc.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)afnclick:(UIButton *)sender {
    [XXProgressHUD showSuccess:@"哈哈哈哈H"];

    [self showNotification];
//    [LBXAlertAction
//        showAlertWithTitle:@"标题"
//                       msg:@"提示消息内容"
//          buttonsStatement:@[ @"取消", @"确认1", @"确认2", @"确认3", @"确认4", @"确认5", @"确认6" ]
//               chooseBlock:^(NSInteger buttonIdx){
//
//               }];
//    [LBXAlertAction showAlertWithTitle:@"提示"
//                                   msg:@"您的帐号在别的设备上登录,您被迫下线！"
//                      buttonsStatement:@[ @"确定" ]
//                           chooseBlock:^(NSInteger buttonIdx){
//
//                           }];
    

    
 
}

- (void)showNotification{
    [self getLKNotificationManager].default_style = LK_NOTIFICATION_BAR_STYLE_DARK;
    LKNotificationBar *notificationBar = [[self getLKNotificationManager] createWithTitle: @"意见反馈" content:@"您的反馈提交成功!感谢您的反馈" icon: [UIImage imageNamed: @"TSYicon"]];
    notificationBar.delegate = self;
    [notificationBar showWithAnimated: YES];
    
    UIViewController *two = [UIViewController new];
    [self.navigationController pushViewController:two animated:YES];
}

- (void)onNavigationBarTouchUpInside:(LKNotificationBar *)navigationBar{
    [navigationBar hideWithAnimated: YES];
}
- (IBAction)cellAction:(UIButton *)sender {

    ShoppingOrderVC *shoppingOrder = [ShoppingOrderVC new];
    [self.navigationController pushViewController:shoppingOrder animated:YES];
}

- (IBAction)tnchu:(UIButton *)sender {

    //创建菜单
    SpreadDropMenu *menu = [[SpreadDropMenu alloc]initWithShowFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width, 300) ShowStyle:MYPresentedViewShowStyleFromTopSpreadStyle callback:^(id callback) {
        
        //在此处获取菜单对应的操作 ， 而做出一些处理
        NSLog(@"-----------------%@",callback);
    }];
    
    //菜单展示
    [self presentViewController:menu animated:YES completion:nil];

}
- (IBAction)tishi:(UIButton *)sender {

}



@end
