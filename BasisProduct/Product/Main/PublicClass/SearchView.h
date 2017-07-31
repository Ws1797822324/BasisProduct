//
//  SearchView.h
//  Product
//
//  Created by Sen wang on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

- (IBAction)searchBtnAction:(UIButton *)sender;
/// 搜索按钮
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

/// 语音搜索
- (IBAction)voiceBtnAction:(UIButton *)sender;

/// 扫描
- (IBAction)scanBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@end
