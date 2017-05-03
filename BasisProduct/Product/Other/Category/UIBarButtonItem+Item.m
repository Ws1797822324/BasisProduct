//
//  UIBarButtonItem+Item.m
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents titleName:(NSString *)name
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)leftbarButtonItemWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action withTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.253 green:0.699 blue:0.463 alpha:1.000] forState:UIControlStateHighlighted];
    button.titleEdgeInsets  = UIEdgeInsetsMake(0, 0, 0, 0);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button setImage:norImage forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button setImage:highImage forState:UIControlStateSelected];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (title) {
        CGSize size = [title sizeWithAttributes: @{NSFontAttributeName: button.titleLabel.font}];
        button.height = size.height + 5;
        button.width = size.width + button.imageView.height + 5;
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else
    {
        button.frame = CGRectMake(0, 0, 40, 30);
    }
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}
+(UIBarButtonItem *)rightbarButtonItemWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action withTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc]init];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.253 green:0.699 blue:0.463 alpha:1.000] forState:UIControlStateHighlighted];
    [button setImage:norImage forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button setImage:highImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleEdgeInsets  = UIEdgeInsetsMake(0, 0, 0, -5);
    
    
    if (title) {
        CGSize size = [title sizeWithAttributes: @{NSFontAttributeName: button.titleLabel.font}];
        
        button.height = size.height;
        button.width = size.width + button.imageView.height + 20;
        // 让按钮内部的所有内容右对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    else
    {
        button.frame = CGRectMake(0, 0, 30, 30);
    }
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}


@end
