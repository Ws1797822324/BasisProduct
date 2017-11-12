//
//  MMPopupViewDemoVC.m
//  Product
//
//  Created by Sen wang on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MMPopupViewDemoVC.h"
#import "ButtonMenuView.h"

@interface MMPopupViewDemoVC () <PTXDatePickerViewDelegate> 

@property (nonatomic, strong) PTXDatePickerView *datePickerView;

@property (nonatomic, strong) NSDate *selectedDate; //代表dateButton上显示的时间。

    @property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)click:(UIButton *)sender;
    
@end

@implementation MMPopupViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datePickerView = [[PTXDatePickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 246.0)];
    _datePickerView.delegate = self;
    
    PublicSection * kk = [PublicSection shareInstance];
    NSLog(@"token = %@" ,kk.token);
    
    ButtonMenuView * buttonMenuView = [[ButtonMenuView alloc]initWithFrame:CGRectMake(0, 400, kScreenWidth, 180)];
    buttonMenuView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:buttonMenuView];
    // Do any additional setup after loading the view from its nib.
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /// 恢复导航栏下那条线
    [self.navigationController.navigationBar lt_reset];
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
    
    [self showAlertTitle:@"测试" message:@"123456789" clickArr:@[@"YY",@"KK"] click:^(NSInteger index) {
        
    }];


    
}
#pragma mark - 弹出一个 sheet

- (IBAction)sheet:(id)sender {
    
    [self showSheetTitle:@"1234" clickArr:@[@"MM",@"CC",@"EE" ] click:^(NSInteger index) {
        
    }];
    
}

- (IBAction)date:(UIButton *)sender {

    [self.view addSubview:_datePickerView];
    [_datePickerView showViewWithDate:_selectedDate animation:YES];
    
    
    _datePickerView.datePickerViewShowModel = PTXDatePickerViewShowModelYearMonthDay;
    
#pragma mark -   设置时间范围 年限范围
    //先更新成PTXDatePickerViewDateRangeModelCustom，再设置maxYear。
    _datePickerView.datePickerViewDateRangeModel = PTXDatePickerViewDateRangeModelCustom;
    _datePickerView.minYear = 1949;
    _datePickerView.maxYear = 2049;
    

}

#pragma mark - PTXDatePickerViewDelegate 代理方法

- (void)datePickerView:(PTXDatePickerView *)datePickerView didSelectDate:(NSDate *)date {
    
    self.selectedDate = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];

    
    NSLog(@"你的选择没有错 %@",[dateFormatter stringFromDate:date]);
}

- (IBAction)click:(UIButton *)sender {
    
    
}
@end
