//
//  PublicSection.m
//  Product
//
//  Created by Sen wang on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PublicSection.h"

static PublicSection *sectionInstance;

@implementation PublicSection

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sectionInstance = [super allocWithZone:zone];
    });
    return sectionInstance;
}
+ (PublicSection *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sectionInstance = [[self alloc] init];
    });
    return sectionInstance;
}


@end
