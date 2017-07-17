//
//  PublishViewController.m
//  Product
//
//  Created by Sen wang on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PublishViewController.h"

#import "OneViewController.h"

#import "TwoViewController.h"


@interface PublishViewController ()


@end

@implementation PublishViewController

- (void)viewDidLoad {
self.title = @"发布";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    self.viewFrame = CGRectMake(0, 100, kScreenWidth, kScreenHeight - 100 );

    self.menuHeight = 35; //导航栏高度
    self.menuItemWidth = 120; //每个 MenuItem 的宽度
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleFlood;//这里设置菜单view的样式

    self.progressColor = [UIColor blueColor];//设置下划线(或者边框)颜色
    self.titleSizeSelected = 14;//设置选中文字大小
    self.titleColorNormal = [UIColor orangeColor];
    self.progressViewBottomSpace = 10;
    self.titleColorSelected = [UIColor greenColor];//设置选中文字颜色
    self.progressViewCornerRadius = 3;
    self.titleSizeNormal = 14;
    self.selectIndex = 0;
    
    
    [super viewDidLoad];
    

    

}



- (NSArray *)titles
{
    return @[@"我是一号", @"我是二号"];
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}


- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    switch (index) {
        case 0: {
            OneViewController *vc = [[OneViewController alloc] init];

            return vc;
        }
            break;
        case 1: {
            TwoViewController *vc = [[TwoViewController alloc] init];
            return vc;
        }
            break;
            
        default: {
            UIViewController *vc = [[UIViewController alloc] init];

            return vc;
        }
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    return self.titles[index];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
