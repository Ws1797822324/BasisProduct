//
//  CFFlowButtonView.h
//  CFFlowButtonView
//
//  Created by 周凌宇 on 15/10/27.
//  Copyright © 2015年 周凌宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFFlowButtonView : UIView

/**
 *  存放需要显示的button
 */
@property (nonatomic, strong) NSMutableArray *buttonList;

/**
 *  通过传入一组按钮初始化CFFlowButtonView
 *
 *  @param buttonList 按钮数组
 *
 *  @return CFFlowButtonView对象
 */
- (instancetype)initWithButtonList:(NSMutableArray *)buttonList;

@end
