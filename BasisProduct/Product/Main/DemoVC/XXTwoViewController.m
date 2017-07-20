//
//  XXTwoViewController.m
//  Product
//
//  Created by Sen wang on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXTwoViewController.h"

@interface XXTwoViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation XXTwoViewController

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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"nnnn  %@",self.navigationController.navigationBar);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor redColor] WithScrollView:scrollView AndValue:64];
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
