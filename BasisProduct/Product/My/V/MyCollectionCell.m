//
//  MyCollectionCell.m
//  Demo
//
//  Created by Sen wang on 2017/6/29.
//  Copyright © 2017年 王森. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell

-(void)awakeFromNib {
    
    [super awakeFromNib];
}

-(void)setModel:(ItemModel *)model {
    
    _model = model;
    
    _imgView.image = [UIImage imageNamed:model.imageName];
    _nameLabel.text = model.itemTitle;
    
}

@end
