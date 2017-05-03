//
//  UIViewController+HUD.h
//  demo
//
//  Created by jeffers on 16/3/28.
//  Copyright © 2016年 cloudcns. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface UIViewController (HUD)

-(void)showSuccess:(NSString *)success;

-(void)showError:(NSString *)error;

-(void)showMessage:(NSString *)message;

-(void)showWaiting;

-(void)showLoading;

-(void)showLoadingWithMessage:(NSString *)message;

-(void)showSaving;

-(void)hideHUD;


@end
