//
//  UIViewController+MAC.h
//  Product
//
//  Created by Sen wang on 2017/8/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMPopupItem.h"

@interface UIViewController (MAC)

/** 
 * 展示Alert提示信息
 */
- (void)showAlertMessage:(NSString *)message;

/**
 * 展示Alert提示信息
 */
- (void)showAlertMessage:(NSString *)message titile:(NSString *)title;
/** * 展示Alert提示信息
 *
 * @param message 提示内容
 * @param title 提示标题
 * @param arr 按钮信息数组
 * @param clickIndex 点击的下标
 */
- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
              clickArr:(NSArray *)arr
                 click:(MMPopupItemHandler)clickIndex;
/**
 *
 * 展示SheetView提示信息
 * @param title 提示标题
 * @param Arr 按钮信息数组
 * @param clickIndex 点击的下标
 */
- (void)showSheetTitle:(NSString *)title clickArr:(NSArray *)Arr click:(MMPopupItemHandler)clickIndex;


@end
