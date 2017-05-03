//
//  UIBarButtonItem+Item.h
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)


+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents titleName:(NSString *)name;

+(UIBarButtonItem *)leftbarButtonItemWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action withTitle:(NSString *)title;


+(UIBarButtonItem *)rightbarButtonItemWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action withTitle:(NSString *)title;



@end
