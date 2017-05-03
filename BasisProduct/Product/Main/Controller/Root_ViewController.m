//
//  Root_ViewController.m
//  Product
//
//  Created by Sen wang on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Root_ViewController.h"

@interface Root_ViewController ()

@end

@implementation Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(250, 250, 250, 0.8);
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // Do any additional setup after loading the view.
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
