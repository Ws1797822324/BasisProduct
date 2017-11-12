//
//  NetWorkManager.h
//  Demo
//
//  Created by Sen wang on 2017/4/27.
//  Copyright © 2017年 Sen wang. All rights reserved.
//

#import "XXVerticalButton.h"

@implementation XXVerticalButton


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        [self setViewLayout];
    }
    
    return self;
}

- (void)createView {
    
    UIImageView *icon = [[UIImageView alloc] init];
    self.icon = icon;
    [self addSubview:self.icon];
    
    UILabel *title = [[UILabel alloc] init];
    title.textColor = kRGB_HEX(0x292d33);
    title.font = [UIFont systemFontOfSize:kFountSize(13)];
    self.title = title;
    [self addSubview:self.title];
    
}

- (void)setViewLayout {
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(7);
        make.width.and.height.offset(45);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.icon.mas_bottom).offset(2);
        make.centerX.mas_equalTo(self.icon);
    }];
}


@end
