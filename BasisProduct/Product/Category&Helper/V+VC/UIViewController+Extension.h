//
//  UIViewController+Extension.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/**
 从xib中加载控制器
 
 */
+ (instancetype)viewControllerFromNib;

/**
 从 storyboard 加载ViewController

 @param storyboardName storyboard  名字
 @param identifier 这个类的 storyboard ID（自己设置）

 */
+ (instancetype)viewControllerFromStoryboardName:(NSString *)storyboardName Identifier:(NSString *)identifier;




@end
