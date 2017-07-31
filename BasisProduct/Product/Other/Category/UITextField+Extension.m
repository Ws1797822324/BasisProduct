//
//  UITextField+Extension.m
//  Product
//
//  Created by Sen wang on 2017/7/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

#pragma mark - 用户在输入电话号码的时候自动格式化为123 4567 8901
- (BOOL)phoneTFValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range
{
    
    NSString *text = self.text;
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }

    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    
    NSString *subString = [text substringToIndex:MIN(text.length, 3)];
    
    newString = [newString stringByAppendingString:subString];
    if (subString.length == 3) {
        newString = [newString stringByAppendingString:@" "];
    }
    
    text = [text substringFromIndex:MIN(text.length, 3)];
    
    if (text.length > 0) {
        NSString *subString2 = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString2];
        if (subString2.length == 4) {
            newString = [newString stringByAppendingString:@" "];
            
        }
        NSString *subString3 = [text substringFromIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString3];
        
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    
    if (newString.length >= 14) {

        return NO;
    }
    if (newString.length == 13) {
        [kNoteCenter postNotificationName:@"phoneinputcomplete" object:nil];
    } else {
        [kNoteCenter postNotificationName:@"phoneinput" object:nil];

    }
    
    [self setText:newString];
    
    return NO;
}

#pragma mark - 用户在输入银行卡号的时候自动格式化为1234 1234 1234 1234 123(16-19位)
- (BOOL)bankCardValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range
{
    
    NSString *text = self.text;
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    
    if (newString.length >= 24) {
        return NO;
    }
    
    [self setText:newString];
    
    return NO;
}

#pragma mark - 用户在输入金钱的时候自动判断两位,一个小数点,如123.12
- (BOOL)moneyValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range
{
    NSString *text             = self.text;
    NSString *decimalSeperator = @".";
    NSCharacterSet *charSet    = nil;
    NSString *numberChars      = @"0123456789";
    
    if ([string isEqualToString:decimalSeperator] && [text length] == 0) {
        return NO;
    }
    
    NSRange decimalRange = [text rangeOfString:decimalSeperator];
    BOOL isDecimalNumber = (decimalRange.location != NSNotFound);
    if (isDecimalNumber) {
        charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
        if ([string rangeOfString:decimalSeperator].location != NSNotFound) {
            return NO;
        }
    }
    else {
        numberChars = [numberChars stringByAppendingString:decimalSeperator];
        charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
    }
    
    NSCharacterSet *invertedCharSet = [charSet invertedSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:invertedCharSet];
    text = [text stringByReplacingCharactersInRange:range withString:trimmedString];
    
    if (isDecimalNumber) {
        NSArray *arr = [text componentsSeparatedByString:decimalSeperator];
        if ([arr count] == 2) {
            if ([arr[1] length] > 2) {
                return NO;
            }
        }
    }
    
    self.text = text;
    return NO;
}
#pragma mark -  任意限制输入内容的输入框(不在允许输入范围内的东西不显示)

/**
 任意限制输入内容的输入框(不在允许输入范围内的东西不显示)
 @param str1 目的字符串
 @param str2 不想要的那个字符串
 */
- (BOOL)randomValueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range targetStr:(NSString *)str1 randomStr:(NSString *)str2
{
    NSLog(@"%s",__func__);
    
    NSString *text = self.text;
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:str2 withString:str1];
    [self setText:text];
    return NO;
    
}


@end
