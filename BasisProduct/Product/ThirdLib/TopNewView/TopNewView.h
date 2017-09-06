//
//  TopNewView.h
//  crowdfunding_SJ
//
//  Created by T_Yang on 16/9/9.
//  Copyright © 2016年 杨 天. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕高度
#define kHeight [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define kWidth [[UIScreen mainScreen] bounds].size.width
//快速生成颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//快速产生字体
#define kFont(n) [UIFont systemFontOfSize:(n)]

@interface TopNewView : UIView

/**

 @param view 整体下滑的 View
 @param content 显示的文字
 */
+ (void)showInView:(UIScrollView *)view content:(NSString *)content;

@end
