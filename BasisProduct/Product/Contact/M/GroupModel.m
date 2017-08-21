//
//  GroupModel.m
//  Product
//
//  Created by Sen wang on 2017/8/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GroupModel.h"
#import "ContactsModel.h"


@implementation GroupModel
#pragma mark - 驼峰属性转成下划线key去字典中取值
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
}

#pragma mark - 属性为数组类型时，要指定数组元素对应的模型类(解析类)
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"contacts": [ContactsModel class]};
}


@end
