//
//  XLPaymentLoadingHUD.m
//  XLPaymentHUDExample
//
//  Created by MengXianLiang on 2017/4/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XXPaymentLoadingHUD.h"

static CGFloat lineWidth = 4.0f;
#define BlueColor [UIColor colorWithRed:16 / 255.0 green:142 / 255.0 blue:233 / 255.0 alpha:1]
/// 动态图片用
static XXPaymentLoadingHUD *Hud = nil;

@implementation XXPaymentLoadingHUD {
    CADisplayLink *_link;
    CAShapeLayer *_animationLayer;

    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _progress;
}

+ (XXPaymentLoadingHUD *)showLoadingIn:(UIView *)view {
    [self hideLoadingIn:view];
    XXPaymentLoadingHUD *hud = [[XXPaymentLoadingHUD alloc] initWithFrame:view.bounds];
    [hud lodingStart];
    [view addSubview:hud];
    return hud;
}

+ (XXPaymentLoadingHUD *)hideLoadingIn:(UIView *)view {
    XXPaymentLoadingHUD *hud = nil;
    for (XXPaymentLoadingHUD *subView in view.subviews) {
        if ([subView isKindOfClass:[XXPaymentLoadingHUD class]]) {
            [subView lodingHide];
            [subView removeFromSuperview];
            hud = subView;
        }
    }
    return hud;
}

- (void)lodingStart {
    _link.paused = false;
}

- (void)lodingHide {
    _link.paused = true;
    _progress = 0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _animationLayer = [CAShapeLayer layer];
    _animationLayer.bounds = CGRectMake(0, 0, 60, 60);
    _animationLayer.position = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0);
    _animationLayer.fillColor = [UIColor clearColor].CGColor;
    _animationLayer.strokeColor = BlueColor.CGColor;
    _animationLayer.lineWidth = lineWidth;
    _animationLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_animationLayer];

    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = true;
}

- (void)displayLinkAction {
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}

- (void)updateAnimationLayer {
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 + _progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress) / 0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _animationLayer.bounds.size.width / 2.0f - lineWidth / 2.0f;
    CGFloat centerX = _animationLayer.bounds.size.width / 2.0f;
    CGFloat centerY = _animationLayer.bounds.size.height / 2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY)
                                                        radius:radius
                                                    startAngle:_startAngle
                                                      endAngle:_endAngle
                                                     clockwise:true];
    path.lineCapStyle = kCGLineCapRound;

    _animationLayer.path = path.CGPath;
}

- (CGFloat)speed {
    if (_endAngle > M_PI) {
        return 0.3 / 60.0f;
    }
    return 2 / 60.0f;
}

#pragma mark - 动态图片
+ (void)showWithDynamicImageStatus:(NSString *)text {
    XXPaymentLoadingHUD *custom = [[XXPaymentLoadingHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Hud = custom;
    [[UIApplication sharedApplication].keyWindow addSubview:custom];

    UIView *customView =
        [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75,
                                                 [UIScreen mainScreen].bounds.size.height / 2 - 50, 150, 120)];
    customView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [custom addSubview:customView];
    customView.layer.masksToBounds = YES;
    customView.layer.cornerRadius = 10;

    UIImageView *heartImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(customView.frame.size.width / 2 - 50, 10, 100, 80.0)];
    [customView addSubview:heartImageView];
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:7];
    for (int i = 1; i <= 5; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DynamicImageArray" ofType:@"bundle"];
        UIImage *image = [UIImage
            imageWithContentsOfFile:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"car%d.png", i]]];
        [images addObject:image];
    }
    heartImageView.animationImages = images;
    heartImageView.animationDuration = 0.4;
    heartImageView.animationRepeatCount = MAXFLOAT;
    [heartImageView startAnimating];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(customView.frame.size.width / 2 - 50, 80, 100, 40)];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    [customView addSubview:label];
}

+ (void)dismissDynamicImageStatus {
    
    [Hud removeFromSuperview];
    

}

@end
