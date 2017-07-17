//
//  MyCollectionCell.h
//  Demo
//
//  Created by Sen wang on 2017/6/29.
//  Copyright © 2017年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemModel.h"

@interface MyCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;



@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (nonatomic ,strong) ItemModel *model;

@end
