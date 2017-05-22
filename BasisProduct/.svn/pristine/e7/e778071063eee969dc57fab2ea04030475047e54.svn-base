//
//  AppDelegate.m
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"

#import "RootTabBarController.h"

#import "NavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    RootTabBarController *tabBarVc = [[RootTabBarController alloc] init];

    NavigationController *NavTabBarVc = [[NavigationController alloc]initWithRootViewController:tabBarVc];
    
    self.window.rootViewController = NavTabBarVc;
    
    
    [self settingIQKeyboard];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
