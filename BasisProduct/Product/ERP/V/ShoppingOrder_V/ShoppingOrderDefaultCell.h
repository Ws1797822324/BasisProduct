//
//  ShoppingOrderDefaultCell.h
//  Product
//
//  Created by Sen wang on 2017/7/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingOrderDefaultCell : UITableViewCell

/// 采购商的名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///右箭头
@property (weak, nonatomic) IBOutlet UIImageView *right_image;
/// 身份类型
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
/// 车牌号
@property (weak, nonatomic) IBOutlet UIButton *automobileNumberBtn;
// ** 选择的购货商名字 */
@property (weak, nonatomic) IBOutlet UILabel *supplier_nameLabel;

- (IBAction)automobileNumberBtnAction:(UIButton *)sender;



@end
