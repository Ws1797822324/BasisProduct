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
#define Start_X          10.0f      // 第一个按钮的X坐标
#define Start_Y          0.0f     // 第一个按钮的Y坐标
#define Width_Space      10.0f      // 2个按钮之间的横间距
#define Height_Space     0.0f     // 竖间距
#define Button_Height   (kScreenHeight * 0.3)    // 高
#define Button_Width    kScreenWidth /6    // 宽
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
        self.shadowView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.11);
        [self addSubview:_shadowView];
        
        // 数据 View
        self.dataView = [[UIView alloc]init];
        
        [self settingDataView];

        [self addSubview:_dataView];
        self.buttonView = [[UIView alloc]init];
        self.buttonView.frame = CGRectMake(0, self.shadowView.height, kScreenWidth, self.shadowView.height);
        self.buttonView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview: _buttonView];
        
        
        NSArray *titles1 = @[@"我的邀请", @"我的分红", @"我的钱包", @"我的评价", @"我的认证"];
        
        for (int a = 0 ; a < titles1.count; a++) {
            NSInteger index = a % 5;
            NSInteger page = a / 5;
            
            
            XXVerticalButton *mapBtn = [[XXVerticalButton alloc] init];
            mapBtn.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"aa%d", a]];
            mapBtn.title.text = titles1[a];
            mapBtn.titleLabel.font = [UIFont systemFontOfSize:kFountSize(13)];
            mapBtn.frame = CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
            mapBtn.tag = a;
            self.mapBtn = mapBtn;
            [_buttonView addSubview:self.mapBtn];
            //按钮点击方法
            [self.mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    
    }
    return self;
}
- (void)mapBtnClick:(XXVerticalButton *)button
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
