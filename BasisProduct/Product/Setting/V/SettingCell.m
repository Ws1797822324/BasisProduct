//
//  SettingCell.m
//  Product
//
//  Created by Sen wang on 2017/7/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.switchView.on = NO;
    [self.switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)switchAction:(UISwitch *)sender
{

    if (sender.tag == 4 ) {
        
        
        if ([sender isOn]) {
            NSLog(@" %ld - 开",sender.tag);
            
        }else {
            NSLog(@"%ld - 关",sender.tag);
        }
    
    } else if (sender.tag == 5) {
        
        if ([sender isOn]) {
            NSLog(@" %ld - 开",sender.tag);
            
        }else {
            NSLog(@"%ld - 关",sender.tag);
        }

        
    }
}
@end
