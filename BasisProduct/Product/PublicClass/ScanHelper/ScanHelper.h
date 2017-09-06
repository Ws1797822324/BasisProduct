//
//  ScanHelper.h
//  ScanHelperDemo
//
//  Created by zhengrui on 17/2/14.
//  Copyright © 2017年 zhengrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScanQRViewController.h"
typedef NS_ENUM(NSInteger, QRScanStyle) {
    qqStyle,        //QQ风格
    ZhiFuBaoStyle,  //支付宝风格
    InnerStyle,     //无边框，内嵌4个角
    weixinStyle,    //微信风格
    OnStyle,        //4个角在矩形框线上,网格动画
    changeSize      //改变扫码区域位置
};

@interface ScanHelper : NSObject

@property (nonatomic , assign) QRScanStyle qRScanStyle;


- (ScanQRViewController *)ScanVCWithStyle:(QRScanStyle )style qrResultCallBack:(void(^)(id result))qrResult;


+ (instancetype)shareInstance;
@end
