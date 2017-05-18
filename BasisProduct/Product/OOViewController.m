//
//  OOViewController.m
//  Product
//
//  Created by Sen wang on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OOViewController.h"

@interface OOViewController ()

@end

@implementation OOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 300;
    
    // Do any additional setup after loading the view from its nib.
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
