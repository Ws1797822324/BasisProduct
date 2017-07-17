//
//  TwoViewController.m
//  Product
//
//  Created by Sen wang on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TwoViewController.h"

#import "XXVerticalButton.h"

@interface TwoViewController ()

@property (nonatomic ,strong) UIButton *cancelButton;


@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingItem];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)settingItem {
    
    
    // View不能交互
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video", @"publish-video"];
    
    NSArray *titles = @[@"找车源", @"找商品", @"找代卖", @"找代收", @"找冷库", @"找土地", @"找农机", @"找档口",@"求助",@"招标",@"招聘"];
    
    // 横排个数
    int maxCols = 4;
    
    CGFloat buttonW = 60;
    CGFloat buttonH = buttonW + 40;
    
    CGFloat buttonStartY = (kScreenHeight - 6.5 * buttonH) * 0.5;
    
    CGFloat buttonStartX = 35;
    
    CGFloat xMargin = (kScreenWidth - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    
    for (int i = 0; i<images.count; i++) {
        
        XXVerticalButton *button = [[XXVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY + kScreenHeight;
        
        button.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        
        self.view.userInteractionEnabled = YES;
        
        
        // 按钮动画
//        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
//        
//        
//        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
//        
//        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
//        
//        
//        anim.springBounciness = 4;
//        
//        anim.springSpeed = 12;
//        
//        // 开始时间 不同
//        anim.beginTime = CACurrentMediaTime() + 0.05 * i;
//        [button pop_addAnimation:anim forKey:nil];
    }
    
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"阅卷错号"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_cancelButton];
    
    _cancelButton.sd_layout
    .bottomSpaceToView(self.view, 15)
    .centerXEqualToView(self.view)
    .widthIs(40)
    .heightIs(40);
}



- (void)cancelAction {
    
    [self cancelWithCompletionBlock:nil];
}


/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 0;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + kScreenHeight;
        // 动画的执行节奏(一开始很慢, 后面很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.02;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                
                [self dismissViewControllerAnimated:NO completion:nil];
                
                !completionBlock ? : completionBlock();
                
            }];
        }
    }
}

- (void)buttonClick:(XXVerticalButton *)button
{
    [self dismissViewControllerAnimated:NO completion:nil];

    
    NSLog(@"diande  -- %ld",(long)button.tag);
    
}
@end
