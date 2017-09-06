//
//  NSDate+extension.h
//  Product
//
//  Created by Sen wang on 2017/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (extension)

//判断时间戳是否为当天,昨天,一周内,年月日
+ (NSString *)timeStringWithTimeInterval:(NSString *)timeInterval;

@end
