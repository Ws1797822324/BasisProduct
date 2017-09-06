//
//  Commodity Cell.m
//  Product
//
//  Created by Sen wang on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommodityCell.h"

@implementation CommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    kViewRadius(_commodity_img, 4);
    [XXHelper setCornerRadiuswithView:_toolView targetAngles:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
    _container = self.contentView;

}

@end
