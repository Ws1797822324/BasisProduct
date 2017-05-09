//
//  Section.m
//  Product
//
//  Created by Sen wang on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXSection.h"

static XXSection *sectionInstance;

@interface XXSection ()


@end

@implementation XXSection



#pragma mark - Init

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sectionInstance = [super allocWithZone:zone];
    });
    return sectionInstance;
}
+ (XXSection *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sectionInstance = [[self alloc] init];
    });
    return sectionInstance;
}


// MARK:  =========  删除多余的cell、 分割线=========

-(void)deleteExtraCellLine: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view removeFromSuperview];
    
}


- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color disposeButton:(UIButton *)button{
    
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = mColor;
                [button setTitle:title forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


- (void)startSeniorWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color disposeButton:(UIButton *)button {
    
    int __block time = (int)timeLine;
    
    button.enabled = NO;
    //获取系统全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //基于全局队列创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置定时器为点击后马上开始，间隔时间为1秒，没有延迟
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), 1*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (time == 0) {
            button.enabled = YES;
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = mColor;
                [button setTitle:title forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        } else {
            time --;
            NSString *string = [NSString stringWithFormat:@"%d%@", time,subTitle];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@",string] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
        }
    });
    
    dispatch_resume(timer);
    
}

// MARK:  =========   图片转成base64编码  =========

-(NSString *) imageConvertFormatBase64imageName:(NSString *)imageName {
    UIImage *originImage = [UIImage imageNamed:imageName];
    
    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}


@end
