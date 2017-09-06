//
//  XXViewController.m
//  Product
//
//  Created by Sen wang on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXViewController.h"
#import "MMPopupViewDemoVC.h"
#import "XXPaymentLoadingHUD.h"
#import "XXPaymentSuccessHUD.h"
#import "ShoppingOrderVC.h"
#import "SpreadDropMenu.h"

@interface XXViewController () <UIImagePickerControllerDelegate, TZImagePickerControllerDelegate, UIAlertViewDelegate,
                                UIActionSheetDelegate, UINavigationControllerDelegate> {
}

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, assign) BOOL allowCrop; // 是否允许裁剪
@property (weak, nonatomic) IBOutlet UIButton *xxButton;

@property (weak, nonatomic) IBOutlet UIView *xxView;

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

    self.testLabel.text = kLocalizedString(@"abc");
    self.title = @"首页";
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController.tabBarItem setBadgeValue:@"3"];
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
    
//    [XXProgressHUD showLoading:@"你大爷的"];
//        [XXPaymentLoadingHUD showWithDynamicImageStatus:@"快跑"];
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [XXPaymentLoadingHUD dismissDynamicImageStatus];
    //    });
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
@end
