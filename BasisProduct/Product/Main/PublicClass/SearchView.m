//
//  SearchView.m
//  Product
//
//  Created by Sen wang on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

-(void)awakeFromNib {
    [super awakeFromNib];
    kViewRadius(self.searchButton, 10);
    
}
- (IBAction)searchBtnAction:(UIButton *)sender {

}
- (IBAction)voiceBtnAction:(UIButton *)sender {
}

- (IBAction)scanBtnAction:(UIButton *)sender {
}
@end
