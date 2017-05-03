//
//  CFFlowButtonView.m
//  CFFlowButtonView
//
//  Created by 周凌宇 on 15/10/27.
//  Copyright © 2015年 周凌宇. All rights reserved.
//

#import "CFFlowButtonView.h"

@implementation CFFlowButtonView

- (instancetype)initWithButtonList:(NSMutableArray *)buttonList {
    if (self = [super init]) {
        _buttonList = buttonList;
        
        for (UIButton *button in _buttonList) {
            [self addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews {

    CGFloat margin = 10;

    // 存放每行的第一个Button
    NSMutableArray *rowFirstButtons = [NSMutableArray array];
    
    // 对第一个Button进行设置
    UIButton *button0 = self.buttonList[0];
    button0.x = margin;
    button0.y = margin;
    [rowFirstButtons addObject:self.buttonList[0]];
    
    // 对其他Button进行设置
    int row = 0;
    for (int i = 1; i < self.buttonList.count; i++) {
        UIButton *button = self.buttonList[i];
        
        int sumWidth = 0;
        int start = (int)[self.buttonList indexOfObject:rowFirstButtons[row]];
        for (int j = start; j <= i; j++) {
            UIButton *button = self.buttonList[j];
                sumWidth += (button.width + margin);
        }
        sumWidth += 10;
        
        UIButton *lastButton = self.buttonList[i - 1];
        if (sumWidth >= self.width) {
            button.x = margin;
            button.y = lastButton.y + margin + button.height;
            [rowFirstButtons addObject:button];
            row ++;
        } else {
            button.x = sumWidth - margin - button.width;
            button.y = lastButton.y;
        }
    }
    
    
    UIButton *lastButton = self.buttonList.lastObject;
    self.height = CGRectGetMaxY(lastButton.frame) + 10;
    

}


@end
