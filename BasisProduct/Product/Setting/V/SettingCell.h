//
//  SettingCell.h
//  Product
//
//  Created by Sen wang on 2017/7/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/// 开关
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
///向右的箭头
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;

/// 缓存数据
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end
