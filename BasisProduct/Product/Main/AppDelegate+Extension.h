//
//  AppDelegate+Extension.h
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarController.h"

@interface AppDelegate (Extension) <UITabBarControllerDelegate, CYLTabBarControllerDelegate>

/// 设置键盘
-(void) settingIQKeyboard;

/// 设置主根控制器
-(void) setRootControllor;

@end
