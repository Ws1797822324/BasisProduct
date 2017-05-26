//
//  UIImageView+Extension.m
//  Product
//
//  Created by Sen wang on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)



- (void)setHeader:(NSString *)url
{
    
    
    UIImage *placeholder = [[UIImage imageNamed:@"circle2"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 下载下来的image有值，就变圆，没有值就用占位图
        self.image = image ? [image circleImage]: placeholder ;
        
        
    }];
}
@end
