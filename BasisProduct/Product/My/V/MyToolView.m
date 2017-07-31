//
//  myToolView.m
//  Demo
//
//  Created by Sen wang on 2017/6/27.
//  Copyright © 2017年 王森. All rights reserved.
//

#import "MyToolView.h"


#import "XXVerticalButton.h"
#import "UIView+Extension.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

@interface MyToolView ()


/// 头像
@property (nonatomic ,strong) UIButton *headBtn;
/// 认证状态
@property (nonatomic ,strong) UIButton *proveType;
/// 姓名
@property (nonatomic ,strong) UILabel *nameLabel;
/// 我的钱包余额
@property (nonatomic ,strong) UILabel *moneyLabel;






@end

@implementation MyToolView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.shadowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zxcbsdhrtujdfnxgjdrt"]];
        self.shadowView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.14);
        [self addSubview:_shadowView];
        
        // 数据 View
        self.dataView = [[UIView alloc]init];
        
        [self settingDataView];

        [self addSubview:_dataView];
        self.buttonView = [[UIView alloc]init];
        self.buttonView.frame = CGRectMake(0, self.shadowView.height, kScreenWidth, self.shadowView.height);
        self.buttonView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview: _buttonView];
        
        
        // 数据
        NSArray *images = @[@"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video"];
        
        NSArray *titles = @[@"我的邀请", @"我的分红", @"我的钱包", @"我的评价", @"我的认证"];
        // 横排个数
        int maxCols = 5;
        
        CGFloat buttonW = 50;
        CGFloat buttonH = buttonW + 40;
        CGFloat buttonStartX = 15;
        
        CGFloat xMargin = (kScreenWidth - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
        
        for (int i = 0; i < maxCols; i++) {
            
            UIButton *button = [[XXVerticalButton alloc] init];
            
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonView addSubview:button];
            
            // 设置内容
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            
            // 计算X
            int col = i % maxCols;
            CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);

            button.height =  buttonH;
            button.width = buttonW;
            button.x = buttonX;
            button.centerY = self.buttonView.height * 0.5;
            
        }
        
    
    }
    return self;
}
- (void)buttonClick:(XXVerticalButton *)button
{
    
    NSLog(@"点的第几个按钮  -- %ld",(long)button.tag);
    
}

-(void) settingDataView {
    self.dataView.x = self.shadowView.x;
    _dataView.y = _shadowView.y;
    self.dataView.width = self.shadowView.width;
    self.dataView.height = self.shadowView.height * 0.8;
    self.headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headBtn.userInteractionEnabled = NO;
    _headBtn.frame = CGRectMake(15, 15, 60, 60);
    [_headBtn setBackgroundImage:[UIImage imageNamed:@"head_image"] forState:UIControlStateNormal];
    [self.dataView addSubview:_headBtn];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.frame = CGRectMake(self.headBtn.width + 30, self.headBtn.x, 100, 30);
    self.nameLabel.text = @"你的名字";
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.dataView addSubview:_nameLabel];
    
    self.proveType = [UIButton buttonWithType:UIButtonTypeCustom];
    self.proveType.frame = CGRectMake(self.nameLabel.x, self.headBtn.height , 40, 15);
    self.proveType.backgroundColor = kRGBColor(255,208,0,1);
    self.proveType.layer.cornerRadius = 6;
    [ self.proveType setTitle:@"已认证" forState:UIControlStateNormal];

    self.proveType.titleLabel.textColor = [UIColor whiteColor];
    self.proveType.titleLabel.font = [UIFont systemFontOfSize:8];
    
    [self.dataView addSubview:_proveType];

    UILabel * tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 80, self.nameLabel.centerY - 10, 80, 20)];
    tempLabel.text = @"我的钱包";
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.font = [UIFont systemFontOfSize:15];
    
    [self.dataView addSubview:tempLabel];

    self.moneyLabel = [[UILabel alloc]init];
    
    
    self.moneyLabel.text = @"￥9987.2";
    self.moneyLabel.textColor = [UIColor whiteColor];
    self.moneyLabel.font = [UIFont systemFontOfSize:21];
    [self.dataView addSubview:_moneyLabel];
[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {

    make.right.equalTo(self.dataView).offset(-20);
    make.centerY.equalTo(self.proveType.mas_centerY);
    make.height.offset(40);
    
}];
}



@end
