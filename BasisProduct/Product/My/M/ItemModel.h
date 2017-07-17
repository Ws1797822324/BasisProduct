//
//  ItemModel.h
//  demo
//
//  Created by zhong on 17/1/16.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Status) {
    StatusMinusSign = 1, // 减号
    StatusPlusSign, // 加号
    StatusCheck, // 对勾
};

@interface ItemModel : NSObject

///  图片名
@property (nonatomic, copy) NSString *imageName;
/// 图片下的文字 item 名字
@property (nonatomic, copy) NSString *itemTitle;
/// item 状态
@property (nonatomic, assign) Status status;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
