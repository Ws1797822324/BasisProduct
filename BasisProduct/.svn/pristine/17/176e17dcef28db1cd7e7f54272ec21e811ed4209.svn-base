//
//  Section.h
//  Product
//
//  Created by Sen wang on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

+ (Section *)shareInstance;



// MARK:  =========  删除多余的cell、 分割线=========

-(void)deleteExtraCellLine: (UITableView *)tableView;


/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title 结束时的
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 *  @param button   要操作的按钮
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color disposeButton:(UIButton *)button;

/**
 *  倒计时按钮 不重置时间
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title 结束时的
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 *  @param button   要操作的按钮
 */

- (void)startSeniorWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color disposeButton:(UIButton *)button;


@end
