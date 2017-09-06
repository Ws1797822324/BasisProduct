//
//  Root_ViewController.m
//  Product
//
//  Created by Sen wang on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kAllRGB;
    self.automaticallyAdjustsScrollViewInsets = NO;


}

-(void)  viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [XXProgressHUD hideHUD];
}

-(void) viewDidDisappear:(BOOL)animated  {
    [super viewDidDisappear:animated];
    [XXProgressHUD hideHUD];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
