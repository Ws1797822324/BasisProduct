//
//  NavigationController.m
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NavigationController.h"

#import "XXPaymentLoadingHUD.h"


@interface NavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;


@end

@implementation NavigationController

+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];

    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    self.navigationBar.barTintColor = [UIColor whiteColor];


}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back"] target:self  action:@selector(popToPre) withTitle:@""];
        }
    
    [super pushViewController:viewController animated:animated];
    
}


- (void)popToPre
{
    [self popViewControllerAnimated:YES];
    [XXProgressHUD hideHUD];
    [XXPaymentLoadingHUD dismissDynamicImageStatus];

}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }else{ // 非根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }
}

@end
