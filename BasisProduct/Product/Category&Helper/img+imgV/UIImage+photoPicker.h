//
//  UIImage+photoPicker.h
//  Product
//
//  Created by Sen wang on 2017/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlbumsModel;

//返回选中的所有图片 , 原图或者压缩图
typedef void(^photoPickerImagesCallback)(NSArray<AlbumsModel *> *imagesModel, NSArray *photos,NSArray *assets);

//返回视频存储的位置
typedef void(^videoBaseInfoCallback)(AlbumsModel *videoModel);


@interface UIImage (photoPicker)

/**
 
 @param imagesCallback block
 @param target 打开相册所需
 @param selectedAssets 已选中的
 @param count 最大可选数量
 */
+ (void)openPhotoPickerGetImages:(photoPickerImagesCallback)imagesCallback target:(UIViewController *)target selectedAssets:(NSMutableArray*)selectedAssets maxCount:(NSInteger)count;



/**
 获取选中的视频
 */
+ (void)openPhotoPickerGetVideo:(videoBaseInfoCallback)callback target:(UIViewController *)target;


@end
