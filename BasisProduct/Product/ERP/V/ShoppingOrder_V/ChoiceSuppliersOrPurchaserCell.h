//
//  ChoiceSuppliersCell.h
//  Product
//
//  Created by Sen wang on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ChoiceSuppliersOrPurchaserCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *icon_imgView;
// ** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *name_label;
// ** 身份标签 */
@property (weak, nonatomic) IBOutlet UILabel *Identity_tag_label;
// ** 商品标签 View */
@property (weak, nonatomic) IBOutlet UIView *commodity_view;
// ** 地理位置 */
@property (weak, nonatomic) IBOutlet UILabel *position_label;


@end
