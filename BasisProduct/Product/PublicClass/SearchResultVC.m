//
//  SearchResultVC.m
//  Product
//
//  Created by Sen wang on 2017/7/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchResultVC.h"

@interface SearchResultVC ()

@end

@implementation SearchResultVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}



- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)Btnpush:(UIButton *)sender {
    
    RootViewController * tempView = [RootViewController new];
    
    tempView.view.backgroundColor = kRandomColor;
    
    [self.navigationController pushViewController:tempView animated:YES];
}

@end
