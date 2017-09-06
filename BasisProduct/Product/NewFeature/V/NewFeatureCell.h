//
//  NewFeatureCell.h
//  Product
//
//  Created by Sen wang on 2017/8/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image_View;
- (IBAction)skipButtonAction:(UIButton *)sender;
@end
