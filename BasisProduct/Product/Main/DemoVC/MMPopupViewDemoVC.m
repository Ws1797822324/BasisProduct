//
//  MMPopupViewDemoVC.m
//  Product
//
//  Created by Sen wang on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MMPopupViewDemoVC.h"

@interface MMPopupViewDemoVC () <PTXDatePickerViewDelegate> 

@property (nonatomic, strong) PTXDatePickerView *datePickerView;

@property (nonatomic, strong) NSDate *selectedDate; //代表dateButton上显示的时间。


@end

@implementation MMPopupViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 弹出 View
- (IBAction)View:(UIButton *)sender {
    UIView *tempView = [[UIView alloc]init];
    tempView.backgroundColor = kRandomColor;
    tempView.centerX = kScreenWidth / 2;
    tempView.centerY = kScreenHeight / 2;
    tempView.width = 100;
    tempView.height = 100;
    KLCPopup *popView =[KLCPopup popupWithContentView:tempView showType:KLCPopupShowTypeSlideInFromTop dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    //  KLCPopupLayout  设置 弹出View停止位置  和从什么方向出现  可不设置
    KLCPopupLayout  popLayout = (KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter));
    
    [popView showWithLayout:popLayout];
}
#pragma mark - 弹出一个 Action
- (IBAction)action:(UIButton *)sender {
    [MMPopupWindow sharedWindow].touchWildToHide = YES;

    MMPopupItemHandler itemHander = ^(NSInteger index){
        
        NSLog(@"click -> NO:%ld",index);
    };
    
    NSArray * items = @[MMItemMake(@"第一个", MMItemTypeNormal, ^(NSInteger index) {
        NSLog(@"hahahh");
    }), MMItemMake(@"第二", MMItemTypeNormal, ^(NSInteger index) {
        NSLog(@"点了第二个");
    }), MMItemMake(@"第三", MMItemTypeHighlight, itemHander)];
    
    MMAlertView *alertView = [[MMAlertView alloc]initWithTitle:@"title" detail:@"TEXT" items:items];
    
    [alertView show];

    
}
#pragma mark - 弹出一个 sheet

- (IBAction)sheet:(id)sender {
    
    [MMPopupWindow sharedWindow].touchWildToHide = YES;   // 点击空余位置popView 消失
    MMPopupItemHandler itemHander = ^(NSInteger index){
        
        NSLog(@"click -> NO:%ld",index);
    };
    
    NSArray * items = @[MMItemMake(@"第一个", MMItemTypeNormal, ^(NSInteger index) {
        NSLog(@"我是第一个");
    }), MMItemMake(@"第二", MMItemTypeNormal, ^(NSInteger index) {
        NSLog(@"点了第二个");
    }), MMItemMake(@"第三", MMItemTypeHighlight, itemHander)];
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"SheetView"
                                                          items:items];
//    sheetView.attachedView.mm_dimAnimationDuration = 3;  //动画时间
    

    [sheetView show];

}

- (IBAction)date:(UIButton *)sender {
    _datePickerView = [[PTXDatePickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 246.0)];
    _datePickerView.delegate = self;
    [self.view addSubview:_datePickerView];
    [_datePickerView showViewWithDate:_selectedDate animation:YES];
    
    
    _datePickerView.datePickerViewShowModel = PTXDatePickerViewShowModelYearMonthDay;
    
#pragma mark -   设置时间范围 年限范围
//    //先更新成PTXDatePickerViewDateRangeModelCustom，再设置maxYear。
//    _datePickerView.datePickerViewDateRangeModel = PTXDatePickerViewDateRangeModelCustom;
//    _datePickerView.minYear = 2000;
//    _datePickerView.maxYear = 2050;
    

}

#pragma mark - PTXDatePickerViewDelegate 代理方法

- (void)datePickerView:(PTXDatePickerView *)datePickerView didSelectDate:(NSDate *)date {
    
    self.selectedDate = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];

    
    NSLog(@"你的选择没有错 %@",[dateFormatter stringFromDate:date]);
}

@end
