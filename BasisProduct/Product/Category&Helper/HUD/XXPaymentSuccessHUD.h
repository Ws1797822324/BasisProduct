//
//  XLPaymentSuccessHUD.h
//  XLPaymentHUDExample
//
//  Created by MengXianLiang on 2017/4/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXPaymentSuccessHUD : UIView<CAAnimationDelegate>


+(XXPaymentSuccessHUD*)showSuccessIn:(UIView*)view;

+(XXPaymentSuccessHUD*)hideSuccessIn:(UIView*)view;

@end
