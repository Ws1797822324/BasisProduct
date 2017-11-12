//
//  UITableView+HD_NoList.h
//  houDaProject
//
//  Created by 波 on 2017/8/8.
//  Copyright © 2017年 heiguoliangle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HD_NoList)

- (void)showNoView:(NSString *)title image:(UIImage *)placeImage certer:(CGPoint)p;

- (void)dismissNoView;

@property (nonatomic, assign, readonly, getter=isShowNoView) BOOL showNoView;

@end
