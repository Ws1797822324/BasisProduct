//
//  TopNewView.m
//  crowdfunding_SJ
//
//  Created by T_Yang on 16/9/9.
//  Copyright © 2016年 杨 天. All rights reserved.
//

#import "TopNewView.h"

#define kTopHeight 120

@interface TopNewView ()
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation TopNewView

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView content:(NSString *)content {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollView = scrollView;
        self.backgroundColor = kColor(227, 181, 117);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        titleLabel.frame = self.bounds;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = kFont(10);
        titleLabel.text = content;
    }
    return self;
}

+ (void)showInView:(UIScrollView *)scrollView content:(NSString *)content {
    TopNewView *topNewView = [[self alloc] initWithFrame:CGRectMake(scrollView.frame.origin.x,
                                                                    scrollView.frame.origin.y,
                                                                    kWidth,
                                                                    kTopHeight)
                                              scrollView:scrollView
                                                 content:content];
    [scrollView.superview addSubview:topNewView];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) return;
    
    [self.scrollView setContentOffset:CGPointMake(0, -kTopHeight) animated:YES];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
}

- (void)dismiss {
    [UIView animateWithDuration:3.0f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        [self removeFromSuperview];
    }];
}

@end
