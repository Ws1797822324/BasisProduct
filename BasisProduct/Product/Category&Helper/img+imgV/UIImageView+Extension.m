//
//  UIImageView+Extension.m
//  Product
//
//  Created by Sen wang on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)



- (void)setHeader:(NSString *)url
{
    
    
    UIImage *placeholder = [[UIImage imageNamed:@"circle2"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 下载下来的image有值，就变圆，没有值就用占位图
        self.image = image ? [image circleImage]: placeholder ;
        
        
    }];
}

- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

//下载单图
- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)imageName
              success:(DownloadImageSuccessBlock)success
               failed:(DownloadImageFailedBlock)failed
             progress:(DownloadImageProgressBlock)progress {
    
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        if (progress) {
            progress(receivedSize * 1.0 / expectedSize);
        }
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        //错误回调
        if (error &&failed) {
            
            failed(error);
            
        } else {
            self.image = image;
            if (success) {
                success(image);
            }
        }
    }];
}


//准备GIF播放
- (void)GIF_PrePlayWithImageNamesArray:(NSArray *)array duration:(NSInteger)duration
{
    self.hidden = NO;
    NSMutableArray *arr = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSString  *_Nonnull imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImage *image = [UIImage imageNamed:imageName];
        [arr addObject:image];
    }];
    //设置序列帧图像数组
    self.animationImages = arr;
    //设置动画时间
    self.animationDuration = 1;
    //设置播放次数，0代表无限次
    self.animationRepeatCount = (NSInteger)duration;
    [self startAnimating];
    //赋值
    //    objc_setAssociatedObject(self ,&imageViewKey ,imageView ,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//停止播放
- (void)GIF_Stop
{
    [self stopAnimating];
}



@end
