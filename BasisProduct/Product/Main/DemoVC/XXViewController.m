//
//  XXViewController.m
//  Product
//
//  Created by Sen wang on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXViewController.h"
#import "MMPopupViewDemoVC.h"

@interface XXViewController () <UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate> {

    
    
}


@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic ,assign) NSInteger maxCount;

@property (nonatomic ,assign) BOOL allowCrop;  // 是否允许裁剪
@property (weak, nonatomic) IBOutlet UIButton *xxButton;



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
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
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
    

self.tabBarItem.badgeValue = @"98";
    
//    [XXProgressHUD showSuccess:@"这是个测试 VC"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 监听tabbar点击的通知
    [kNoteCenter addObserver:self selector:@selector(tabBarSelect) name:@"XXTabBarDidSelectNotification" object:nil];
}

/**
 *  点击tabBar
 */
- (void)tabBarSelect
{

    if ( self.view.isShowingOnKeyWindow) {
        
        NSLog(@"你点击了当前的 tabBarItem");
    }
    
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
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    
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
    imagePickerVc.allowPickingOriginalPhoto = false;  // 选原图不能裁剪
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
    //imagePickerVc.allowPreview = NO;
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [_xxButton setBackgroundImage:photos[0] forState:UIControlStateNormal];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}



- (IBAction)push:(UIButton *)sender {
    MMPopupViewDemoVC *vc = [MMPopupViewDemoVC new];
    vc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController: vc animated:YES];
}

@end
