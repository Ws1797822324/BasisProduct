//
//  IMJIETagFrame.h
//  TDS
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width ) - 100
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define TagTitleFont [UIFont systemFontOfSize:12]
@interface IMJIETagFrame : NSObject

/** 标签名字数组 */
@property (nonatomic, strong) NSArray *tagsArray;
/** 标签frame数组 */
@property (nonatomic, strong) NSMutableArray *tagsFrames;
/** 全部标签的高度 */
@property (nonatomic, assign) CGFloat tagsHeight;
/** 标签间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMargin;
/** 标签行间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsLineSpacing;
/** 标签最小内边距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMinPadding;

@property (nonatomic ,assign) CGFloat maxWidth;


@end
