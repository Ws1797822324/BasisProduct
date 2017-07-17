//
//  UIButton+HCBState.h
//  ToolKit
//
//  Created by wangshuaipeng on 16/9/9.
//  gitHub https://github.com/spWang/UIButton-State
//  Copyright © 2016年 Mac－pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HCBState)
/** 获取当前borderColor */
@property(nullable, nonatomic, readonly, strong) UIColor *hcb_currentBorderColor;

/** 获取当前backgroundColor */
@property(nullable, nonatomic, readonly, strong) UIColor *hcb_currentBackgroundColor;

/** 获取当前titleLabelFont */
@property(nonatomic, readonly, strong) UIFont *hcb_currentTitleLabelFont;

/** 设置不同状态下的borderColor(支持动画效果) */
- (void)hcb_setborderColor:(UIColor *)borderColor forState:(UIControlState)state animated:(BOOL)animated;

/** 设置不同状态下的backgroundColor(支持动画效果) */
- (void)hcb_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated;

/** 设置不同状态下的titleLabelFont */
- (void)hcb_setTitleLabelFont:(UIFont *)titleLabelFont forState:(UIControlState)state;

/** 获取某个状态的borderColor */
- (nullable UIColor *)hcb_borderColorForState:(UIControlState)state;

/** 获取某个状态的backgroundColor */
- (nullable UIColor *)hcb_backgroundColorForState:(UIControlState)state;

/** 获取某个状态的titleLabelFont */
- (UIFont *)hcb_titleLabelFontForState:(UIControlState)state;


/** 为自己的subView设置不同状态下的属性 */
- (void)hcb_setSubViewValue:(nullable id)value forKeyPath:(NSString *)keyPath forState:(UIControlState)state withSubViewTag:(NSInteger)tag;


#pragma mark - 使用key-value方式设置
/** key:需要将UIControlState枚举包装为NSNumber类型即可(此方式无动画) */
- (void)hcb_configBorderColors:(NSDictionary <NSNumber *,UIColor *>*)borderColors;

/** key:需要将UIControlState枚举包装为NSNumber类型即可(此方式无动画) */
- (void)hcb_configBackgroundColors:(NSDictionary <NSNumber *,UIColor *>*)backgroundColors;

/** key:需要将UIControlState枚举包装为NSNumber类型即可 */
- (void)hcb_configTitleLabelFont:(NSDictionary <NSNumber *,UIFont *>*)titleLabelFonts;


/** 切换按钮状态时,执行动画的时间,默认0.25s(只有动画执行完毕后,才能会执行下一个点击事件) */
@property (nonatomic, assign) NSTimeInterval hcb_animatedDuration;

@end

NS_ASSUME_NONNULL_END
