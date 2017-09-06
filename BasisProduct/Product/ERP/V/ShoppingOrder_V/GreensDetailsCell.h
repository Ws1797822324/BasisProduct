//
//  GreensDetailsCell.h
//  Product
//
//  Created by Sen wang on 2017/8/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreensDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 必填星号 */
@property (weak, nonatomic) IBOutlet UIImageView *stars_imageView;
@property (weak, nonatomic) IBOutlet UITextField *textF;
/** 最右边的Label */
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

/** 修改采购标准的 View */
@property (weak, nonatomic) IBOutlet UIView *modifyView;

- (IBAction)modifyButtonAction:(UIButton *)sender;

/** 价格待定按钮 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *price_width;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
- (IBAction)priceButtonAction:(UIButton *)sender;
/** 右箭头*/
@property (weak, nonatomic) IBOutlet UIImageView *jianTou_Image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jianTou_width;

@end
