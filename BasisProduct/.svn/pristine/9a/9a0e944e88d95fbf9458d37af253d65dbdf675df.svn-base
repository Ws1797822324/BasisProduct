//
//  XXProgressHUD.m
//  XXGeneralProject
//
//  Created by 叶炯 on 2017/4/12.
//  Copyright © 2017年 YeJiong. All rights reserved.
//

#import "XXProgressHUD.h"

// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE    15.0f

@implementation XXProgressHUD

+ (instancetype)sharedHUD {
    static id hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[self alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    });
    return hud;
}

+ (void)showStatus:(XXProgressHUDStatus)status text:(NSString *)text {
    
    XXProgressHUD *HUD = [XXProgressHUD sharedHUD];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.contentColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    [HUD setShowNow:YES];

    HUD.label.text = text;
    HUD.label.textColor = [UIColor whiteColor];
    [HUD setRemoveFromSuperViewOnHide:YES];
    HUD.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [HUD setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"XXProgressHUD" ofType:@"bundle"];
    
    switch (status) {
            
        case XXProgressHUDStatusSuccess: {
            
            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Success.png"];
            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            HUD.customView = sucView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });
        }
            break;
            
        case XXProgressHUDStatusError: {
            
            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Error.png"];
            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            HUD.customView = errView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });
        }
            break;
            
        case XXProgressHUDStatusLoading: {
            HUD.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
            
        case XXProgressHUDStatusWaitting: {
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Warn.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });

        }
            break;
            
        case XXProgressHUDStatusInfo: {
            
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Info.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });
        }
            break;
            
        default:
            break;
    }
}

+ (void)showMessage:(NSString *)text {
    
    [self hideHUD];
    XXProgressHUD *HUD = [XXProgressHUD sharedHUD];
    HUD.bezelView.color = [UIColor blackColor];
    [HUD showAnimated:YES];
    [HUD setShowNow:YES];
    HUD.label.text = text;
    HUD.contentColor=[UIColor whiteColor];
    [HUD setMinSize:CGSizeZero];
    [HUD setMode:MBProgressHUDModeText];
    //    HUD.dimBackground = YES;
    [HUD setRemoveFromSuperViewOnHide:YES];
    [HUD hideAnimated:YES afterDelay:2.0f];
    HUD.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[XXProgressHUD sharedHUD] setShowNow:NO];
        [[XXProgressHUD sharedHUD] hideAnimated:YES];
    });
}

+ (void)showWaiting:(NSString *)text {
    
    [self showStatus:XXProgressHUDStatusWaitting text:text];
}

+ (void)showError:(NSString *)text {
    
    [self showStatus:XXProgressHUDStatusError text:text];
}

+ (void)showSuccess:(NSString *)text {
    
    [self showStatus:XXProgressHUDStatusSuccess text:text];
}

+ (void)showLoading:(NSString *)text {
    
    [self showStatus:XXProgressHUDStatusLoading text:text];
}

+ (void)hideHUD {
    
    [[XXProgressHUD sharedHUD] setShowNow:NO];
    [[XXProgressHUD sharedHUD] hideAnimated:YES];
}


@end
