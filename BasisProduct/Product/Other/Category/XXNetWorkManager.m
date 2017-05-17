//
//  XXNetWorkManager.m
//  Demo
//
//  Created by Sen wang on 2017/4/27.
//  Copyright © 2017年 Sen wang. All rights reserved.
//

#import "XXNetWorkManager.h"

#import "XXProgressHUD.h"



@implementation XXNetWorkManager

+ (instancetype)sharedManager {
    
    static  XXNetWorkManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    return manager;
}


-(instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        
        /**设置请求超时时间*/
        
        self.requestSerializer.timeoutInterval = kTime;
        
        /**设置相应的缓存策略*/
        
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        response.removesKeysWithNullValues = YES;
        
        self.responseSerializer = response;
        
        // 是否信任 非法证书
        self.securityPolicy.allowInvalidCertificates = YES;
        
    }
    return self;
}
#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                [XXNetWorkManager sharedManager].networkStats =  StatusUnknown;
                
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                [XXNetWorkManager sharedManager].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                [XXNetWorkManager sharedManager].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [XXNetWorkManager sharedManager].networkStats=StatusReachableViaWiFi;
                NSLog(@"WIFI--%lu",[XXNetWorkManager sharedManager].networkStats);
                break;
        }
    }];
    [mgr startMonitoring];
}

+ (void) requestWithMethod:(HTTPMethod)method withParams:(id)params withHud:(BOOL)hud withPrint:(BOOL)print withUrlString:(NSString *)urlStr withSuccessBlock:(successBlock)success withFailuerBlock:(failuerBlock)failuer {
    
    
    if (hud) {
        [XXProgressHUD showLoading:@"请稍后..."];
    }
    
    switch (method) {
        case GET:
        {
            [[XXNetWorkManager sharedManager] GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                NSLog(@"请求成功 URLStr \n\n --- %@\n\n",task.currentRequest.URL);
                success(responseObject);
                
                if(print) {
                    
                    NSLog(@"\n successPrint = \n %@\n\n",responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败 URLStr \n\n --- %@\n\n",task.currentRequest.URL);
                failuer(error);

                
                [XXProgressHUD showWaiting:@"网络请求失败稍后重试"];
                [self requestCancle];
                if(print) {
                    
                    NSLog(@"\n failuerPrint = \n %@\n\n",error);
                }
                
            }];
            break;
        }
        case POST:
        {
            [[XXNetWorkManager sharedManager] POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"请求成功 URLStr \n\n --- %@\n\n",task.currentRequest.URL);
                
                success(responseObject);

                
                if(print) {
                    
                    NSLog(@"\n successPrint = \n %@\n\n",responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败 URLStr \n\n --- %@\n\n",task.currentRequest.URL);
                
                failuer(error);
                
                [XXProgressHUD showWaiting:@"网络请求失败稍后重试"];
                
                [self requestCancle];
                if(print) {
                    
                    NSLog(@"\n failuerPrint = \n%@\n\n",error);
                }
                
            }];

            break;
        }
            
        default:
            break;
    }
}


#pragma mark - 多图上传
/**
 *  上传图片
 *
 *  @param operations   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm width      图片要被压缩到的宽度
 *  @param urlString    上传的url---请填写完整的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 *
 */
+(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )defineWidth withUrlString:(NSString *)urlString withSuccessBlock:(successBlock)successBlock withFailurBlock:(failuerBlock)failureBlock withUpLoadProgress:(uploadProgress)progress;
{
    
    
    //1.创建管理者对象
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSUInteger i = 0 ;
        
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imageArray) {
            
            UIImage *newImage = nil;
            CGSize imageSize = image.size;
            CGFloat width = imageSize.width;
            CGFloat height = imageSize.height;
            CGFloat targetWidth = defineWidth;
            CGFloat targetHeight = height / (width / targetWidth);
            CGSize size = CGSizeMake(targetWidth, targetHeight);
            CGFloat scaleFactor = 0.0;
            CGFloat scaledWidth = targetWidth;
            CGFloat scaledHeight = targetHeight;
            CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
            if(CGSizeEqualToSize(imageSize, size) == NO){
                CGFloat widthFactor = targetWidth / width;
                CGFloat heightFactor = targetHeight / height;
                if(widthFactor > heightFactor){
                    scaleFactor = widthFactor;
                }
                else{
                    scaleFactor = heightFactor;
                }
                scaledWidth = width * scaleFactor;
                scaledHeight = height * scaleFactor;
                if(widthFactor > heightFactor){
                    thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
                }else if(widthFactor < heightFactor){
                    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
                }
            }
            UIGraphicsBeginImageContext(size);
            CGRect thumbnailRect = CGRectZero;
            thumbnailRect.origin = thumbnailPoint;
            thumbnailRect.size.width = scaledWidth;
            thumbnailRect.size.height = scaledHeight;
            
            [image drawInRect:thumbnailRect];
            
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            if(newImage == nil){
                
                NSAssert(!newImage,@"图片压缩失败");
            }
            
            UIGraphicsEndImageContext();
            
            NSData * imgData = UIImageJPEGRepresentation(newImage, .5);
            
            //拼接data
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
            
            i++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        
    }];
}



// MARK:  =========  取消全部的网络请求  =========

+(void)requestCancle {
    
    [[XXNetWorkManager sharedManager].tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark -   取消指定的url请求/
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string
{
    
    NSError * error;
    
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    
    NSString * urlToPeCanced = [[[[XXNetWorkManager sharedManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    
    
    for (NSOperation * operation in [XXNetWorkManager sharedManager].operationQueue.operations) {
        
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            
            //请求的url匹配
            
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                
                [operation cancel];
                
            }
        }
        
    }
}

@end
