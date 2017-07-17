//
//  AppDelegate+Extension.m
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate+Extension.h"

#import "LoginViewController.h"

#import "RootTabBarController.h"




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
    [IQKeyboardManager sharedManager].enableAutoToolbar = true;
    
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    
    [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:false];
    
    [[IQKeyboardManager sharedManager] setToolbarTintColor:[UIColor redColor]];
    
    /**
     输入框距离键盘的距离
     */
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:10.f];
    
}
#pragma mark - 设置主控制器
-(void)setRootControllor {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    RootTabBarController *tabBarVc = [[RootTabBarController alloc] init];
    
    LoginViewController * loginVC = [LoginViewController viewControllerFromNib];
    
    self.window.rootViewController = loginVC;
    
    [self.window makeKeyAndVisible];

}

@end
