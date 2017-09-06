//
//  GreensDetailsCell.m
//  Product
//
//  Created by Sen wang on 2017/8/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GreensDetailsCell.h"

@implementation GreensDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.stars_imageView.hidden = YES;
    self.modifyView.backgroundColor = kHexColor(@"#477BFF");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)modifyButtonAction:(UIButton *)sender {
}
- (IBAction)priceButtonAction:(UIButton *)sender {
}
@end
