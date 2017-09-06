//
//  XXTextView.h
//  Product
//
//  Created by Sen wang on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXTextView : UITextView

@property (copy, nonatomic, nullable) IBInspectable NSString *xx_placeholder;

@property (strong, nonatomic, nullable) IBInspectable UIColor *xx_placeholderColor;

@property (strong, nonatomic, nullable) UIFont *xx_placeholderFont;


@end
