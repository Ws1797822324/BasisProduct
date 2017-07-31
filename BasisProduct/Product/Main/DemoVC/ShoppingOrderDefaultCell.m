//
//  ShoppingOrderDefaultCell.m
//  Product
//
//  Created by Sen wang on 2017/7/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShoppingOrderDefaultCell.h"

@implementation ShoppingOrderDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectedView = [[UIView alloc] initWithFrame:self.frame];
    selectedView.backgroundColor = [UIColor colorWithRed:191.0 / 255 green:220.0 / 255 blue:199.0 / 255 alpha:0.6];
    self.selectedBackgroundView = selectedView;
    
    _identityLabel.hidden = true;
    _automobileNumberBtn.hidden = true;
    kViewRadius(_identityLabel, 2);
    // Initialization code
}



//- (void)layoutSubviews {
//    [super layoutSubviews];
//    for (UIView *subView in self.subviews){
//        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
//            UIView *confirmView=(UIView *)[subView.subviews firstObject];
//            // 改背景颜色
//            confirmView.backgroundColor=[UIColor colorWithHexString:@"dd5044"];
//           
//            if([confirmView isKindOfClass:NSClassFromString(@"UIButton")]){
//                UIButton *deletebtn=(UIButton *)confirmView;
//                // 改删除按钮的字体
//                [deletebtn setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
//                [deletebtn setTitle:nil forState:UIControlStateNormal];
//            }
//            
//            break;
//        }
//    }
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -  点击车牌号

- (IBAction)automobileNumberBtnAction:(UIButton *)sender {
    
//    self.right_image.transform = sender.selected ? CGAffineTransformMakeRotation(M_PI_2*2) : CGAffineTransformMakeRotation(0);
    

}

@end
