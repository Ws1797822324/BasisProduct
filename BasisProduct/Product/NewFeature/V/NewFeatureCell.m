//
//  NewFeatureCell.m
//  Product
//
//  Created by Sen wang on 2017/8/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewFeatureCell.h"

#import "CYLTabBarControllerConfig.h"

@implementation NewFeatureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _image_View.backgroundColor = kRandomColor;
    // Initialization code
}

- (IBAction)skipButtonAction:(UIButton *)sender {

    [kUserDefaults setObject:@"10000" forKey:@"skipActionComplete"];

    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    
    [UIView animateWithDuration:0.2f animations:^{
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;

    }];
}
@end
