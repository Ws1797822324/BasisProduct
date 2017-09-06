//
//  UIViewController+MAC.m
//  Product
//
//  Created by Sen wang on 2017/8/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIViewController+MAC.h"

@implementation UIViewController (MAC)

- (void)showAlertMessage:(NSString *)message {
    [self showAlertMessage:message titile:@"提示"];
}
- (void)showAlertMessage:(NSString *)message titile:(NSString *)title {
    MMPopupItemHandler block = ^(NSInteger index) {
        NSLog(@"clickd %@ button", @(index));
    };
    NSArray *items = @[ MMItemMake(@"确定", MMItemTypeHighlight, block) ];
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:message items:items];
    [alertView show];
}


- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
                clickArr:(NSArray *)arr
                   click:(MMPopupItemHandler)clickIndex {
    if (!arr || arr.count <= 0) {
        return;
    }
    [MMPopupWindow sharedWindow].touchWildToHide = YES;

    __block NSMutableArray *items = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
   
        [items addObject:MMItemMake(obj, (idx == arr.count - 1) ? MMItemTypeHighlight : MMItemTypeNormal, clickIndex)];
    }];
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:message items:items];

    [alertView show];
}


- (void)showSheetTitle:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler)clickIndex {
    if (!arr || arr.count <= 0) {
        return;
    }
    [MMPopupWindow sharedWindow].touchWildToHide = YES;

    __block NSMutableArray *items = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [items addObject:MMItemMake(obj, MMItemTypeNormal, clickIndex)];
    }];
    [[[MMSheetView alloc] initWithTitle:title items:items] show];
};



@end
