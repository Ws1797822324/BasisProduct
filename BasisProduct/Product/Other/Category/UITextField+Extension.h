//
//  UITextField+Extension.h
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

///  用户在输入电话号码的时候自动格式化为123 4567 8901

- (BOOL)phoneTFValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range
;
///用户在输入银行卡号的时候自动格式化为1234 1234 1234 1234 123(16-19位)
- (BOOL)bankCardValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range;

///用户在输入金钱的时候自动判断两位,一个小数点,如123.12
- (BOOL)moneyValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range;

///任意限制输入内容的输入框(不在允许输入范围内的东西不显示)
- (BOOL)randomValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range targetStr:(NSString *)str1 randomStr:(NSString *)str2;

@end
