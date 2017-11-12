//
//  ButtonMenuView.h
//  Product
//
//  Created by Sen wang on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXVerticalButton.h"


@protocol ButtonMenuViewDelegate <NSObject>

@optional

-(void)didClickButton:(XXVerticalButton *)button;

@end

@interface ButtonMenuView : UIView


@property (nonatomic,strong)XXVerticalButton *mapBtn;

@property(nonatomic,weak) id<ButtonMenuViewDelegate> delegate;


@end
