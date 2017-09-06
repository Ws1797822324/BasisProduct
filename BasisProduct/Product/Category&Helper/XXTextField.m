//
//  XXTextField.m
//  Product
//
//  Created by Sen wang on 2017/8/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXTextField.h"

#define Default_FontColor kRGBColor(77, 150, 132, 1)
@implementation XXTextField

//通过代码创建
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
} //通过xib创建
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}
- (void)setUpUI {
    // 设置border
    // self.layer.masksToBounds = YES;
    // self.layer.cornerRadius = 22;
    // self.backgroundColor = Default_FontColor;
    // self.layer.borderColor = [UIColor blackColor].CGColor;
    // self.layer.borderWidth = 1;
    //字体大小
    self.font = [UIFont systemFontOfSize:15];
    //字体颜色
    self.textColor = Default_FontColor;
    //光标颜色
    self.tintColor = self.textColor;
    //占位符的颜色和大小
    [self setValue:kRGBColor(167, 167, 167, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    // 不成为第一响应者
    [self resignFirstResponder];
}
/** * 当前文本框聚焦时就会调用 */

- (BOOL)becomeFirstResponder {
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
} /** * 当前文本框失去焦点时就会调用 */
- (BOOL)resignFirstResponder {
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
//控制placeHolder的位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 15, bounds.origin.y, bounds.size.width - 15, bounds.size.height);
    return inset;
}
//控制显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect inset = CGRectMake(bounds.origin.x + 15, bounds.origin.y, bounds.size.width - 15, bounds.size.height);
    return inset;
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds { CGRect inset = CGRectMake(bounds.origin.x +15, bounds.origin.y, bounds.size.width -15, bounds.size.height); return inset; }

@end
