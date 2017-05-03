//
//  TabBarController.m
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootTabBarController.h"

#import "NavigationController.h"

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

    self.tabBar.itemTitleColor = [UIColor blueColor];
    // 选中时的字体颜色
    self.tabBar.itemTitleSelectedColor = [UIColor orangeColor];
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    [self setUpTabBar];

    
    }
#pragma mark - 设置tabBar
- (void)setUpTabBar
{

    
    // 设置数字样式的badge的位置和大小
    [self.tabBar setNumberBadgeMarginTop:2
                       centerMarginRight:20
                     titleHorizonalSpace:8
                      titleVerticalSpace:2];
    // 设置小圆点样式的badge的位置和大小
    [self.tabBar setDotBadgeMarginTop:5
                    centerMarginRight:15
                           sideLength:10];
    
    UIViewController *controller1 = self.viewControllers[0];
    UIViewController *controller2 = self.viewControllers[1];
    UIViewController *controller3 = self.viewControllers[2];
    UIViewController *controller4 = self.viewControllers[3];
    controller1.yp_tabItem.badge = 8;
    controller2.yp_tabItem.badge = 88;
    controller3.yp_tabItem.badge = 120;
    controller4.yp_tabItem.badgeStyle = YPTabItemBadgeStyleNumber;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{

    UIViewController *controller1 = [[UIViewController alloc] init];

    controller1.yp_tabItemTitle = @"第一";
    controller1.yp_tabItemImage = [UIImage imageNamed:@"tabbar_home"];
    controller1.yp_tabItemSelectedImage = [UIImage imageNamed:@"tabbar_home_selected"];

    
    
    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.yp_tabItemTitle = @"第二";
    controller2.yp_tabItemImage = [UIImage imageNamed:@"tabbar_message_center"];
    controller2.yp_tabItemSelectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
   
    
    UIViewController *controller3 = [[UIViewController alloc] init];
    controller3.yp_tabItemTitle = @"第三";
    controller3.yp_tabItemImage = [UIImage imageNamed:@"tabbar_discover"];
    controller3.yp_tabItemSelectedImage = [UIImage imageNamed:@"tabbar_discover_selected"]; UIViewController *
    
    
    controller4 = [[UIViewController alloc] init];
    controller4.yp_tabItemTitle = @"第四";
    controller4.yp_tabItemImage = [UIImage imageNamed:@"tabbar_profile"];
    controller4.yp_tabItemSelectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
   
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, nil];

    
    // 生成一个居中显示的YPTabItem对象，即“+”号按钮
//    YPTabItem *item = [YPTabItem buttonWithType:UIButtonTypeCustom];
//    item.title = @"+";
//    item.titleColor = [UIColor yellowColor];
//    item.backgroundColor = [UIColor darkGrayColor];
//    item.titleFont = [UIFont boldSystemFontOfSize:20];
//    
//////     设置其size，如果不设置，则默认为与其他item一样
//     item.size = CGSizeMake(80, 60);
////     高度大于tabBar，所以需要将此属性设置为NO
//    self.tabBar.clipsToBounds = NO;
//    
//    [self.tabBar setSpecialItem:item
//             afterItemWithIndex:1
//                     tapHandler:^(YPTabItem *item) {
//                         NSLog(@"item--->%ld", (long)item.index);
//                     }];

}



@end
