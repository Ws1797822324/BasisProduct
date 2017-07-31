//
//  Commodity Cell.h
//  Product
//
//  Created by Sen wang on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commodity_img;

@property (nonatomic, strong) UIView *container;

// 数量背后的灰色背景
@property (weak, nonatomic) IBOutlet UIView *toolView;

@property (weak, nonatomic) IBOutlet UILabel *commodity_Num;

@property (weak, nonatomic) IBOutlet UILabel *commodity_name;
@end
