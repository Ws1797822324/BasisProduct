
#pragma mark - 该工程里的一些三方库使用  示例

#pragma mark  KLCPopup  弹出View 
 
 KLCPopup *popView =[KLCPopup popupWithContentView:tempView showType:KLCPopupShowTypeSlideInFromBottom dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
 //  KLCPopupLayout  设置 弹出View停止位置  和从什么方向出现  可不设置
 KLCPopupLayout  popLayout = (KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom));
 
 [popView showWithLayout:popLayout];

 
#pragma mark -  PTXDatePickerView 时间选择器  


 设置代理 <PTXDatePickerViewDelegate >

 @property (nonatomic, strong) PTXDatePickerView *datePickerView;
 
 @property (nonatomic, strong) NSDate *selectedDate; //代表dateButton上显示的时间。

 _datePickerView = [[PTXDatePickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 246.0)];
 _datePickerView.delegate = self;
 [self.view addSubview:_datePickerView];
 [_datePickerView showViewWithDate:_selectedDate animation:YES];
 
 
 _datePickerView.datePickerViewShowModel = PTXDatePickerViewShowModelYearMonth;
 
 #pragma mark - PTXDatePickerViewDelegate 代理方法

 - (void)datePickerView:(PTXDatePickerView *)datePickerView didSelectDate:(NSDate *)date {
 
 self.selectedDate = date;
 
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
 [dateFormatter setDateFormat:@"yyyy-MM"];
 [_timeButton setTitle:[dateFormatter stringFromDate:date] forState:UIControlStateNormal];
 
 
 }
 
 // MARK:  =========  MJRefresh  =========

 self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
 self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
 
 self.tableView.mj_header.automaticallyChangeAlpha = YES;
 
 [self.tableView.mj_header beginRefreshing];
 
 self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

 
 #pragma mark - 关于侧滑返回设置

项目中加入了一个 NAVC的分类  所以  隐藏导航栏用
self.fd_prefersNavigationBarHidden = YES;

设置侧滑范围  默认是全屏
self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 300;

如果想要scrollView（或之类）支持全屏策侧滑返回（scrollView滚动到最左的时候），自定义的scrollView，实现此方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
