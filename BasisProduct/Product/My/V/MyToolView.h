//
//  myToolView.h
//  Demo
//
//  Created by Sen wang on 2017/6/27.
//  Copyright © 2017年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyToolView : UIView

///  头像那排灰色的 View
@property (nonatomic ,strong) UIImageView * shadowView;
///  信息 View
@property (nonatomic ,strong) UIView * dataView;
///  下面那五个按钮
@property (nonatomic ,strong) UIView *buttonView;


@end
