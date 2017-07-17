//
//  SettingVC.h
//  Product
//
//  Created by Sen wang on 2017/7/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"

#import "SettingCell.h"



@interface SettingVC : RootViewController <UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)singOutAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *singOut;


@end
