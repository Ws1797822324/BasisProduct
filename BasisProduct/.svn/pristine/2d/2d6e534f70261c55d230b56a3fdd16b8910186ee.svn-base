//
//  NetWorkManager.h
//  Demo
//
//  Created by Sen wang on 2017/4/27.
//  Copyright © 2017年 Sen wang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

// 请求成功回调
typedef void(^successBlock)(id objc);
// 请求失败回调
typedef void(^failuerBlock)(id error);
//上传进度回调
typedef void(^uploadProgress)(float progress);



// 请求类型


typedef NS_ENUM(NSUInteger, HTTPMethod) {
    GET = 1,
    POST
};


typedef NS_ENUM(NSUInteger, NetworkStatus) {
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi

};

// MARK:  =========  设置请求超时时长  =========

#define kTime 7

@interface XXNetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/**
 *  获取网络
 */
@property (nonatomic,assign)NetworkStatus networkStats;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;


/**
 AFN 网络请求

 @param method 请求方式
 @param params 参数
 @param hud 是否要HUD
 @param print 是否打印请求结果
 @param urlStr 请求链接
 @param success 成功返回
 @param failuer 失败数据
 */

+ (void) requestWithMethod:(HTTPMethod)method withParams:(id)params withHud:(BOOL)hud withPrint:(BOOL)print withUrlString:(NSString *)urlStr withSuccessBlock:(successBlock)success withFailuerBlock:(failuerBlock)failuer;

/**
 *  上传图片
 *
 *  @param operations   上传图片预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm width      图片要被压缩到的宽度
 *  @param urlString    上传的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 */

+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )defineWidth withUrlString:(NSString *)urlString withSuccessBlock:(successBlock)successBlock withFailurBlock:(failuerBlock)failureBlock withUpLoadProgress:(uploadProgress)progress;

/**
 取消请求
 */
+(void)requestCancle;

/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;


@end
