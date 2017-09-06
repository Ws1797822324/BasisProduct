//
//  AppDelegate+Extension.m
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate+Extension.h"

#import "LoginViewController.h"

#import "CYLTabBarControllerConfig.h"

#import "CYLPlusButtonSubclass.h"

#import "NewFeatureController.h"


#define RANDOM_COLOR [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]


@implementation AppDelegate (Extension)



-(void) settingIQKeyboard {
    
    
    [IQKeyboardManager sharedManager].enable = true;
    /**
     点击屏幕是否收起键盘
     */
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = true;
    
    /**
     是否显示文本区域占位符
     */
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = true;
    /**
     控制键盘上的工具条文字颜色是否用户自定义
     */
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = true;
    /**
     控制是否显示键盘上的工具条。
     */
    [IQKeyboardManager sharedManager].enableAutoToolbar = false;
    
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    
    [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:false];
    
    [[IQKeyboardManager sharedManager] setToolbarTintColor:[UIColor darkGrayColor]];
    
    /**
     输入框距离键盘的距离
     */
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:20.f];
    
    
    
    
}


#pragma mark - 设置主控制器
-(void)setRootControllor {

    NewFeatureController * newFeatureC = [[NewFeatureController alloc]init];
    LoginViewController * loginVC = [LoginViewController viewControllerFromNib];

    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [CYLPlusButtonSubclass registerPlusButton];
    
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc]init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;


//    NSLog(@"手机型号 %@",[XXHelper getUserPhoneModelNumber]);
        NSDictionary *currentVersion = [NSBundle mainBundle].infoDictionary;

    if ([[kUserDefaults objectForKey:@"skipActionComplete"] integerValue] != 10000) {
        self.window.rootViewController = newFeatureC;

    } else {

        self.window.rootViewController = tabBarControllerConfig.tabBarController;

    }

    /// 存储版本号
    [kUserDefaults setObject: currentVersion[@"CFBundleShortVersionString"] forKey:@"productVersion"];
    
    
    
    
    [tabBarController setViewDidLayoutSubViewsBlock:^(CYLTabBarController *aTabBarController) {
        
        //添加提示动画，引导用户点击
        [self addScaleAnimationOnView:aTabBarController.viewControllers[3].cyl_tabButton.cyl_tabImageView repeatCount:8];
    }];
    
    tabBarController.delegate = self;

    
    [self.window makeKeyAndVisible];

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
    
    UIView *animationView;
    animationView = [control cyl_tabImageView];

    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
        
    } else {
    
//    NSLog(@"点击的第 %ld个 item ",[self cyl_tabBarController].selectedIndex);
    NSString *index = [NSString stringWithFormat:@"%ld",[self cyl_tabBarController].selectedIndex];
    
    if ([index isEqualToString:[kUserDefaults objectForKey:@"item.index"]]) {

//        NSLog(@"点击了同一个 tabbar");
    }
    
    [kUserDefaults setObject: index forKey:@"item.index"];
        
    }
    
    [self addScaleAnimationOnView:animationView repeatCount:1];
   
    
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {


    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}


#pragma mark - -------------------------------------------------------
// MARK: ------ 融云 ------


/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {

        
        
        [LBXAlertAction showAlertWithTitle:@"提示" msg:@"您的帐号在别的设备上登录,您被迫下线！" buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
            
        }];
        LoginViewController *loginVC = [LoginViewController viewControllerFromNib];
        NavigationController *_navi = [[NavigationController alloc]
                                              initWithRootViewController:loginVC];
        self.window.rootViewController  = _navi;
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        // token  无效
    }else if (status == ConnectionStatus_DISCONN_EXCEPTION){
        [[RCIMClient sharedRCIMClient] disconnect];

        
        
        [LBXAlertAction showAlertWithTitle:@"提示" msg:@"您的账号被封禁" chooseBlock:^(NSInteger buttonIdx) {
            
        } buttonsStatement:@"知道了"];

        LoginViewController *loginVC = [LoginViewController viewControllerFromNib];
        NavigationController *_navi = [[NavigationController alloc]
                                              initWithRootViewController:loginVC];
        self.window.rootViewController = _navi;
    }
}













@end
