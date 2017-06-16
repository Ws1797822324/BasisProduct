//
//  XLPaymentLoadingHUD.h
//  XLPaymentHUDExample
//
//  Created by MengXianLiang on 2017/4/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXPaymentLoadingHUD : UIView

+ (XXPaymentLoadingHUD *)showLoadingIn:(UIView *)view;

+ (XXPaymentLoadingHUD *)hideLoadingIn:(UIView *)view;

/**
 添加动态图提示

 @param text 提示文字
 */

+ (void)showWithDynamicImageStatus:(NSString *)text;

+ (void)dismissDynamicImageStatus;
@end
