//
//  UIImage+Extension.h
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/**
 把方形图片变成圆的

 @return 圆形图片
 */
- (UIImage *)circleImage;

// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 拉伸图片

 @param imageName 图片名字
 @return 图片
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;


/**
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
- (UIImage *)imgCompressed:(UIImage *)sourceImg targetWidth:(CGFloat)defineWidth;

#pragma mark - 不让从相册或者相机里取出的图片方向错位
- (UIImage *)fixOrientation:(UIImage *)aImage;

#pragma mark - 压缩 Data 数据
- (NSData *)compressedData;

#pragma mark - 压缩 Data 数据  参数区间(0...1)
- (NSData *)compressedData:(CGFloat)compressionQuality;

@end
