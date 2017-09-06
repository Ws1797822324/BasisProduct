//
//  ItemCell.m
//  demo
//
//  Created by zhong on 17/1/16.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import "ItemCell.h"
#import "ItemModel.h"

@interface ItemCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *rightUpperButton;
@end

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kHexColor(@"#F7F7F7");
        kViewRadius(self, 6);
        CGFloat containerX = 10;
        CGFloat containerY = 5;
        CGFloat containerW = self.bounds.size.width - 2 * containerX;
        CGFloat containerH = self.bounds.size.height - 2 * containerY;
        _container = [[UIView alloc] initWithFrame:CGRectMake(containerX, containerY, containerW, containerH)];
        _container.backgroundColor = kHexColor(@"#F7F7F7");
//        _container.backgroundColor = [UIColor redColor];
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake((containerW - 40) / 2, 6, 40, 40)];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_icon.frame), containerW, containerH - CGRectGetMaxY(_icon.frame))];
        _titleLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSInteger wh = 30;
        _rightUpperButton = [[UIButton alloc] initWithFrame:CGRectMake(_container.width - wh * 0.5 , _container.x - wh * 0.5 , wh, wh)];
        [_rightUpperButton addTarget:self action:@selector(rightUpperButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_container addSubview:_icon];
        [_container addSubview:_titleLabel];
        [_container addSubview:_rightUpperButton];
        [self.contentView addSubview:_container];
        
    }
    return self;
}

- (void)setItemModel:(ItemModel *)itemModel {
    _itemModel = itemModel;
    
    _icon.image = [UIImage imageNamed:itemModel.imageName];
    
    _titleLabel.text = itemModel.itemTitle;
    switch (itemModel.status) {
        case StatusMinusSign:
            [_rightUpperButton setImage:[UIImage imageNamed:@"图标_06"] forState:UIControlStateNormal]; // -
            break;
        case StatusPlusSign:
            [_rightUpperButton setImage:[UIImage imageNamed:@"图标_10"] forState:UIControlStateNormal]; // +
            break;
        case StatusCheck:
            [_rightUpperButton setImage:[UIImage imageNamed:@"图标_08"] forState:UIControlStateNormal];  // √
            break;
            
        default:
            break;
    }
}

- (void)setIsEditing:(BOOL)isEditing {
    _rightUpperButton.hidden = !isEditing;
    
}

- (void)rightUpperButtonAction {
    if ([self.delegate respondsToSelector:@selector(rightUpperButtonDidTappedWithItemCell:)]) {
        [self.delegate rightUpperButtonDidTappedWithItemCell:self];
    }
}



@end
