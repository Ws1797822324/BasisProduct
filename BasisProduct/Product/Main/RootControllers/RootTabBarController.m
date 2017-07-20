//
//  TabBarController.m
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootTabBarController.h"

#import "NavigationController.h"

#import "XXViewController.h"

#import "MyViewController.h"

#import "XXTwoViewController.h"
@interface RootTabBarController () 

@property (nonatomic ,copy) NSMutableArray *itemArr;

@end

@implementation RootTabBarController


-(NSMutableArray *)itemArr {
    
    if (_itemArr == nil) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.tabBar.backgroundColor = kRGBColor(250, 250, 250, 0.8);
// 选中时的字体颜色
    self.selectedItemTitleColor = [UIColor greenColor];
    
    self.itemTitleColor = [UIColor darkGrayColor];
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{

    XXViewController *controller1 = [[XXViewController alloc] init];

    controller1.title = @"第一";
    controller1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    controller1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    NavigationController *NaVC1 = [[NavigationController alloc]initWithRootViewController:controller1];
    
    XXTwoViewController *controller2 = [[XXTwoViewController alloc] init];

    controller2.title = @"第二";
    controller2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    controller2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    NavigationController *NaVC2 = [[NavigationController alloc]initWithRootViewController:controller2];
    
    UIViewController *controller3 = [[UIViewController alloc] init];
    controller3.view.backgroundColor = kRandomColor;
    controller3.title = @"第三";
    controller3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    controller3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
    NavigationController *NaVC3 = [[NavigationController alloc]initWithRootViewController:controller3];

     MyViewController *controller4 = [[MyViewController alloc] init];
    controller4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    controller4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
    NavigationController *NaVC4 = [[NavigationController alloc]initWithRootViewController:controller4];

    self.viewControllers = [NSMutableArray arrayWithObjects:NaVC1, NaVC2, NaVC3, NaVC4, nil];

    

    
}



@end
