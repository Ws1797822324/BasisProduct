//
//  UIImageView+Extension.h
//  Product
//
//  Created by Sen wang on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AlbumsModel.h"

typedef void(^DownloadImageSuccessBlock)(UIImage *image);
typedef void(^DownloadImageFailedBlock)(NSError *error);
typedef void(^DownloadImageProgressBlock)(CGFloat progress);



@interface UIImageView (Extension)

/**
 加载圆形头像

 @param url 头像url
 */
- (void)setHeader:(NSString *)url;

/**
 *  异步加载图片
 *
 *  @param url       图片地址
 *  @param imageName 占位图片名
 */

- (void)downloadImage:(NSString *)url placeholder:(NSString *)imageName;

/**
 *  异步加载图片，可以监听下载进度，成功或失败
 *
 *  @param url       图片地址
 *  @param imageName 占位图片名
 *  @param success   下载成功
 *  @param failed    下载失败
 *  @param progress  下载进度
 */

- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)imageName
              success:(DownloadImageSuccessBlock)success
               failed:(DownloadImageFailedBlock)failed
             progress:(DownloadImageProgressBlock)progress;

//播放GIF
- (void)GIF_PrePlayWithImageNamesArray:(NSArray *)array duration:(NSInteger)duration;
//停止播放
- (void)GIF_Stop;


@end
