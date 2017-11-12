//
//  ButtonMenuView.m
//  Product
//
//  Created by Sen wang on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ButtonMenuView.h"

#define Start_X          0.0f      // 第一个按钮的X坐标
#define Start_Y          0.0f     // 第一个按钮的Y坐标
#define Width_Space      0.0f      // 2个按钮之间的横间距
#define Height_Space     0.0f     // 竖间距
#define Button_Height   (kScreenHeight * 0.12)    // 高
#define Button_Width    kScreenWidth/5    // 宽



@interface ButtonMenuView ()<UIScrollViewDelegate>
{
    UIView *_backView1;
    UIView *_backView2;
    UIPageControl *_pageControl;
}
@end

@implementation ButtonMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //
        
        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.25)];
        
        _backView2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight * 0.16)];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.25)];
        scrollView.contentSize = CGSizeMake(2 * kScreenWidth, kScreenHeight * 0.25);
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        [scrollView addSubview:_backView1];
        [scrollView addSubview:_backView2];
        [self addSubview:scrollView];
        
        NSArray *titles1 = @[@"水电维修", @"房屋维修", @"管道疏通", @"保洁清洁",@"沐浴用品",@"保姆月嫂",@"居家养老",@"家电清洗",@"智能电子",@"助力行走"];
        NSArray *titles2 = @[@"家电维修", @"数码维修", @"电脑网络", @"锁具服务", @"二手回收",@"生活护理",@"养老机构",@"长者旅游"];
        
        for (int a = 0 ; a < titles1.count; a++) {
            NSInteger index = a % 5;
            NSInteger page = a / 5;
            

            XXVerticalButton *mapBtn = [[XXVerticalButton alloc] initWithFrame:frame];
            mapBtn.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"aa%d", a]];
            mapBtn.title.text = titles1[a];
            mapBtn.titleLabel.font = [UIFont systemFontOfSize:kFountSize(13)];
            mapBtn.frame = CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
            mapBtn.tag = a;
            self.mapBtn = mapBtn;
            [_backView1 addSubview:self.mapBtn];
            //按钮点击方法
            [self.mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        for (int b = 0 ; b < titles2.count; b++) {
            NSInteger index = b % 5;
            NSInteger page = b / 5;
            
            // 圆角按钮
            XXVerticalButton *mapBtn = [[XXVerticalButton alloc] initWithFrame:frame];
            mapBtn.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"aa%d", (int)(b+titles1.count)]];
            mapBtn.title.text = titles2[b];
            mapBtn.titleLabel.font = kFont(kFountSize(13));
            mapBtn.frame = CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Height + Height_Space)+Start_Y, Button_Width, Button_Height);
            mapBtn.tag = b + 4;
            
            self.mapBtn = mapBtn;
            [_backView2 addSubview:self.mapBtn];
            //按钮点击方法
            [self.mapBtn addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
        //
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        
        
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(_backView1.mas_bottom).offset(0);
            make.centerX.mas_equalTo(self);
            make.height.equalTo(@15);
        }];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    }
    
    return self;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
    
}

- (void)mapBtnClick:(XXVerticalButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didClickButton:)]) {
        [self.delegate didClickButton:btn];
    }
}

@end
