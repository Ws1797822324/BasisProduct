//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)


- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  @param backgroundColor 最终显示颜色
 *  @param scrollView 当前滑动视图
 *  @param value 滑动临界值，依据需求设置
 */
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor WithScrollView:(UIScrollView *)scrollView AndValue:(CGFloat)value;


/**
 *  隐藏导航栏下的横线，背景色置空
 */
- (void)hiddenLine;

/**
 *  还原导航栏
 */
- (void)lt_reset;


- (void)lt_setElementsAlpha:(CGFloat)alpha;

- (void)lt_setTranslationY:(CGFloat)translationY;

@end
