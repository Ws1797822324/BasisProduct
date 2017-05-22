//
//  Section.m
//  Product
//
//  Created by Sen wang on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXSection.h"

static XXSection *sectionInstance;

@interface XXSection ()


@end

@implementation XXSection



#pragma mark - Init

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sectionInstance = [super allocWithZone:zone];
    });
    return sectionInstance;
}
+ (XXSection *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sectionInstance = [[self alloc] init];
    });
    return sectionInstance;
}




@end
