//
//  PTXDatePickerView.m
//  PTXDatePickerView
//
//  Created by pantianxiang on 17/1/12.



#import "PTXDatePickerView.h"

#define PTXTOOLBAR_HEIGHT 40.0 //顶部工具栏高度。
#define PTXTITLE_HEIGHT 40.0 //标题高度。
#define PTXDURATION 0.3 //动画时长。
#define PTXTITLE_LABEL_START_TAG 1 //从左往右第一个标题Label的Tag值。

@interface PTXDatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *datePickerView;
    UIToolbar *toolbar;
    
    //数据源。
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
    NSMutableArray *hourArray;
    NSMutableArray *minuteArray;
    
    //最大值。
    NSInteger maxMonth;
    NSInteger maxDay;
    NSInteger maxHour;
    NSInteger maxMinute;
    
    //选中行数。
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    NSInteger selectedHourRow;
    NSInteger selectedMinuteRow;
    
    //总标题数。
    NSInteger totalTitleLabel;
}

@end

@implementation PTXDatePickerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _minYear = 1970;
        _visible = NO;
        _datePickerViewShowModel = PTXDatePickerViewShowModelDefalut;
        _datePickerViewDateRangeModel = PTXDatePickerViewDateRangeModelCurrent;
        [self __initView];
        [self __initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _minYear = 1970;
        _visible = NO;
        _datePickerViewShowModel = PTXDatePickerViewShowModelDefalut;
        _datePickerViewDateRangeModel = PTXDatePickerViewDateRangeModelCurrent;
        [self __initView];
        [self __initData];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    toolbar.frame = CGRectMake(0, 0, width, PTXTOOLBAR_HEIGHT);
    
    CGFloat labelWidth = width / totalTitleLabel;
    for (NSInteger tag = 0; tag <= totalTitleLabel; tag++) {
        UILabel *label = (UILabel *)[self viewWithTag:PTXTITLE_LABEL_START_TAG + tag];
        label.frame = CGRectMake(tag * labelWidth, PTXTOOLBAR_HEIGHT, labelWidth, PTXTITLE_HEIGHT);
    }
    
    datePickerView.frame = CGRectMake(0, PTXTOOLBAR_HEIGHT + PTXTITLE_HEIGHT, width, height - PTXTOOLBAR_HEIGHT - PTXTITLE_HEIGHT);
}

- (void)__initView {
    self.backgroundColor = [UIColor whiteColor];
    
    //顶部工具栏。
    toolbar = [[UIToolbar alloc]init];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName : kRGBColor(109, 109, 109, 1)} forState:UIControlStateNormal];
    
    UIBarButtonItem *blankButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *completionButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completion)];
    [completionButton setTitleTextAttributes:@{NSForegroundColorAttributeName : kRGBColor(109, 109, 109, 1)} forState:UIControlStateNormal];
    
    [toolbar setItems:@[cancelButton,blankButton,completionButton]];
    [self addSubview:toolbar];
    
    //标题。
    [self __initTitleView];
    
    //UIPickerView.
    datePickerView = [[UIPickerView alloc]init];
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.showsSelectionIndicator = YES;
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    [self addSubview:datePickerView];
}

- (void)__initTitleView {
    NSArray *titleArray = nil;
    switch (_datePickerViewShowModel) {
        case PTXDatePickerViewShowModelDefalut:
            //            [datePickerView selectRow:selectedHourRow inComponent:3 animated:NO];
            //            [datePickerView selectRow:selectedMinuteRow inComponent:4 animated:NO];
            totalTitleLabel = 5;
            titleArray = @[@"年",@"月",@"日",@"时",@"分"];
            break;
        case PTXDatePickerViewShowModelYearMonthDay:
            totalTitleLabel = 3;
            titleArray = @[@"年",@"月",@"日"];
            break;
        case PTXDatePickerViewShowModelYearMonthDayHour:
            totalTitleLabel = 4;
            titleArray = @[@"年",@"月",@"日",@"时"];
            //            [datePickerView selectRow:selectedHourRow inComponent:3 animated:NO];
            break;
        case PTXDatePickerViewShowModelYearMonth:
            totalTitleLabel = 2;
            titleArray = @[@"年",@"月"];
            
            break;
    }
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = [titleArray objectAtIndex:i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = PTXTITLE_LABEL_START_TAG + i;
        [self addSubview:titleLabel];
    }
}

- (void)__initData {
    //初始化最大值。
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *currentDateComponents = [calendar components:calendarUnit fromDate:currentDate];
    _maxYear = [currentDateComponents year];
    maxMonth = [currentDateComponents month];
    maxDay = [currentDateComponents day];
    maxHour = [currentDateComponents hour];
    maxMinute = [currentDateComponents minute];
    
    //初始化当前时间。
    NSInteger currentYear = _maxYear;
    NSInteger currentMonth = maxMonth;
    NSInteger currentDay = maxDay;
    NSInteger currentHour = maxHour;
    NSInteger currentMinute = maxMinute;
    
    //初始化年份数组(范围自定义)。
    yearArray = [[NSMutableArray alloc]init];
    for (NSInteger i = _minYear; i <= currentYear; i ++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    selectedYearRow = [yearArray indexOfObject:[NSString stringWithFormat:@"%ld",currentYear]];
    
    //初始化月份数组(1-12)。
    monthArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= currentMonth; i++) {
        [monthArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    selectedMonthRow = currentMonth - 1;
    
    //初始化天数数组(1-31)。
    dayArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= currentDay; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    selectedDayRow = currentDay - 1;
    
    //初始化小时数组(0-23)。
    hourArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i <= currentHour; i++) {
        [hourArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    selectedHourRow = currentHour;
    
    //初始化分钟数组(0-59)。
    minuteArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i <= currentMinute; i++) {
        [minuteArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    selectedMinuteRow = currentMinute;
}

#pragma mark - Public
- (void)showViewWithDate:(NSDate *)date animation:(BOOL)animation{
    [self __showWithAnimation:animation];
    
    if (!date) {
        date = [NSDate date];
    }
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:date];
    
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    
    if (_datePickerViewDateRangeModel == PTXDatePickerViewDateRangeModelCurrent) {
        //更新时间最大值为当前系统时间。
        NSDateComponents *currentDateComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
        _maxYear = [currentDateComponents year];
        maxMonth = [currentDateComponents month];
        maxDay = [currentDateComponents day];
        maxHour = [currentDateComponents hour];
        maxMinute = [currentDateComponents minute];
        
        /**
         *  显示时间是否小于等于当前系统时间。
         *  PS:这里比较时间之所以不用earlierDate:或laterDate:方法，是因为这里没有比较秒数。
         */
        BOOL isEarly = NO;
        if (year == _maxYear && month == maxMonth && day == maxDay && hour == maxHour && minute && maxMinute) {
            //相等情况。
            isEarly = YES;
        }else {
            if (year < _maxYear) {
                isEarly = YES;
            }else if (month < maxMonth) {
                isEarly = YES;
            }else if (day < maxDay) {
                isEarly = YES;
            }else if (hour < maxHour) {
                isEarly = YES;
            }else if (minute < maxMinute) {
                isEarly = YES;
            }
        }
        NSAssert(isEarly, @"当前模式下不允许显示时间大于当前系统时间，如有需要请更换时间范围模式！");
        
    }else if (_datePickerViewDateRangeModel == PTXDatePickerViewDateRangeModelCustom) {
        /**
         *  下面两个步骤，可以根据自己需要自选一个。
         *  步骤1:限定最大年份，如果超出大值则终止。
         *  步骤2:如果超出最大年份，则更新最大年份值继续显示。
         *
         *  PS:这里选择步骤2.
         */
        
        /*
         
         //步骤1.
         NSAssert(_maxYear > year, @"年份超出最大范围，如有需要请更新最大年份范围！");
         
         */
        
        //步骤2。
        if (year > _maxYear) {
            _maxYear = year;
        }
    }
    
    
    [self resetYearArray];
    [self resetMonthArrayWithYear:year];
    [self resetDayArrayWithYear:year month:month];
    [self resetHourArrayWithYear:year month:month day:day];
    [self resetMinuteArrayWithYear:year month:month day:day hour:hour];
    [datePickerView reloadAllComponents];
    
    
    if (_datePickerViewShowModel == PTXDatePickerViewShowModelDefalut) {// 年月日时分
        [datePickerView selectRow:[yearArray indexOfObject:[NSString stringWithFormat:@"%ld",year]] inComponent:0 animated:YES];
        [datePickerView selectRow:[monthArray indexOfObject:[NSString stringWithFormat:@"%ld",month]] inComponent:1 animated:YES];
        [datePickerView selectRow:[dayArray indexOfObject:[NSString stringWithFormat:@"%ld",day]] inComponent:2 animated:YES];
        [datePickerView selectRow:[hourArray indexOfObject:[NSString stringWithFormat:@"%ld",hour]] inComponent:3 animated:YES];
        [datePickerView selectRow:[minuteArray indexOfObject:[NSString stringWithFormat:@"%ld",minute]] inComponent:4 animated:YES];
    }else if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonthDayHour) { // 年月日时
        [datePickerView selectRow:[yearArray indexOfObject:[NSString stringWithFormat:@"%ld",year]] inComponent:0 animated:YES];
        [datePickerView selectRow:[monthArray indexOfObject:[NSString stringWithFormat:@"%ld",month]] inComponent:1 animated:YES];
        [datePickerView selectRow:[dayArray indexOfObject:[NSString stringWithFormat:@"%ld",day]] inComponent:2 animated:YES];
        [datePickerView selectRow:[hourArray indexOfObject:[NSString stringWithFormat:@"%ld",hour]] inComponent:3 animated:YES];
    } else if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonthDay) { // 年月日
        [datePickerView selectRow:[yearArray indexOfObject:[NSString stringWithFormat:@"%ld",year]] inComponent:0 animated:YES];
        [datePickerView selectRow:[monthArray indexOfObject:[NSString stringWithFormat:@"%ld",month]] inComponent:1 animated:YES];
        [datePickerView selectRow:[dayArray indexOfObject:[NSString stringWithFormat:@"%ld",day]] inComponent:2 animated:YES];
    } else if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonth) { // 年月
        [datePickerView selectRow:[yearArray indexOfObject:[NSString stringWithFormat:@"%ld",year]] inComponent:0 animated:YES];
        [datePickerView selectRow:[monthArray indexOfObject:[NSString stringWithFormat:@"%ld",month]] inComponent:1 animated:YES];
    }
}

- (void)hideViewWithAnimation:(BOOL)animation {
    [self __hideWithAnimation:animation];
}

#pragma mark - Private
/**
 *  除了重置年份外，月、天、时和分均在原有基础上新增或减少，避免过多无谓的循环。
 */

#pragma mark 重置年份
- (void)resetYearArray
{
    //先判断是否需要重置。
    NSInteger minYear = [yearArray[0] integerValue];
    NSInteger maxYear = [yearArray[yearArray.count - 1] integerValue];
    if (_minYear == minYear && _maxYear == maxYear) {
        return;
    }
    
    [yearArray removeAllObjects];
    for (NSInteger i = _minYear; i <= _maxYear; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    //重置年份选中行，防止越界。
    selectedYearRow = selectedYearRow > [yearArray count] - 1 ? [yearArray count] - 1 : selectedYearRow;
}

#pragma mark 重置月份
- (void)resetMonthArrayWithYear:(NSInteger)year
{
    NSInteger totalMonth = 12;
    if (_maxYear == year) {
        totalMonth = maxMonth; //限制月份。
    }
    
    NSInteger lastMonth = [monthArray[monthArray.count - 1] integerValue]; //数组中最大月份。
    if (lastMonth < totalMonth) {
        while (++lastMonth <= totalMonth) {
            [monthArray addObject:[NSString stringWithFormat:@"%ld",lastMonth]];
        }
    }else if (lastMonth > totalMonth) {
        while (lastMonth > totalMonth) {
            [monthArray removeObject:[NSString stringWithFormat:@"%ld",lastMonth]];
            lastMonth--;
        }
    }
    
    //重置月份选中行，防止越界。
    selectedMonthRow = selectedMonthRow > [monthArray count] - 1 ? [monthArray count] - 1: selectedMonthRow;
}

#pragma mark 重置天数
- (void)resetDayArrayWithYear:(NSInteger)year month:(NSInteger)month {
    
    NSInteger totalDay = 0;
    if (_maxYear == year && maxMonth == month) {
        totalDay = maxDay; //限制最大天数。
    }else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        totalDay = 31;
    }
    else if(month == 2)
    {
        if (((year % 4 == 0 && year % 100 != 0 ))|| (year % 400 == 0)) {
            totalDay = 29;
        }
        else
        {
            totalDay = 28;
        }
    }
    else
    {
        totalDay = 30;
    }
    
    NSInteger lastDay = [dayArray[dayArray.count - 1] integerValue]; //数组中最大天数。
    if(lastDay < totalDay) {
        while (++lastDay <= totalDay) {
            [dayArray addObject:[NSString stringWithFormat:@"%ld",lastDay]];
        }
    }
    else if (lastDay > totalDay) {
        while (lastDay > totalDay) {
            [dayArray removeObject:[NSString stringWithFormat:@"%ld",lastDay]];
            lastDay--;
        }
    }
    
    //重置天数选中行，防止越界。
    selectedDayRow = selectedDayRow > [dayArray count] - 1 ? [dayArray count] - 1 : selectedDayRow;
}

#pragma mark 重置小时
- (void)resetHourArrayWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSInteger totalHour = 23;
    if (_maxYear == year && maxMonth == month && maxDay == day) {
        totalHour = maxHour; //限制小时。
    }
    
    NSInteger lastHour = [hourArray[hourArray.count - 1] integerValue]; //数组中最大小时。
    if (lastHour < totalHour) {
        while (++lastHour <= totalHour) {
            [hourArray addObject:[NSString stringWithFormat:@"%ld",lastHour]];
        }
    }else if (lastHour > totalHour){
        while (lastHour > totalHour) {
            [hourArray removeObject:[NSString stringWithFormat:@"%ld",lastHour]];
            lastHour--;
        }
    }
    
    //重置小时选中行，防止越界。
    selectedHourRow = selectedHourRow > [hourArray count] - 1 ? [hourArray count] - 1 : selectedHourRow;
}

#pragma mark 重置分钟
- (void)resetMinuteArrayWithYear:(NSInteger)year
                           month:(NSInteger)month
                             day:(NSInteger)day
                            hour:(NSInteger)hour {
    NSInteger totalMinute = 59;
    if (_maxYear == year && maxMonth == month && maxDay == day && maxHour == hour) {
        totalMinute = maxMinute; //限制分钟。
    }
    
    NSInteger lastMinute = [minuteArray[minuteArray.count - 1] integerValue]; //数组中最大分钟。
    if (lastMinute < totalMinute) {
        while (++lastMinute <= totalMinute) {
            [minuteArray addObject:[NSString stringWithFormat:@"%ld",lastMinute]];
        }
    }else if (lastMinute > totalMinute){
        while (lastMinute > totalMinute) {
            [minuteArray removeObject:[NSString stringWithFormat:@"%ld",lastMinute]];
            lastMinute--;
        }
    }
    
    //重置分钟选中行，防止越界。
    selectedMinuteRow = selectedHourRow > [minuteArray count] - 1 ? [minuteArray count] - 1 : selectedMinuteRow;
}

#pragma mark 取消
- (void)cancel {
    [self __hideWithAnimation:YES];
}

#pragma mark 完成
- (void)completion {
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    
    [dateComponents setYear:[[yearArray objectAtIndex:[datePickerView selectedRowInComponent:0]] integerValue]];
    
    [dateComponents setMonth:[[monthArray objectAtIndex:[datePickerView selectedRowInComponent:1]] integerValue]];
    
    if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonthDay) {
        
        [dateComponents setDay:[[dayArray objectAtIndex:[datePickerView selectedRowInComponent:2]] integerValue]];
        
        
    } else if (_datePickerViewShowModel == PTXDatePickerViewShowModelDefalut) {
        
        [dateComponents setHour:[[hourArray objectAtIndex:[datePickerView selectedRowInComponent:3]] integerValue]];
        
        [dateComponents setDay:[[dayArray objectAtIndex:[datePickerView selectedRowInComponent:2]] integerValue]];
        
        [dateComponents setHour:[[hourArray objectAtIndex:[datePickerView selectedRowInComponent:3]] integerValue]];
        [dateComponents setMinute:[[minuteArray objectAtIndex:[datePickerView selectedRowInComponent:4]] integerValue]];
    }else if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonthDayHour) {
        [dateComponents setHour:[[hourArray objectAtIndex:[datePickerView selectedRowInComponent:3]] integerValue]];
        [dateComponents setDay:[[dayArray objectAtIndex:[datePickerView selectedRowInComponent:2]] integerValue]];
        
    }
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *selectedDate = [calendar dateFromComponents:dateComponents];
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerView:didSelectDate:)]) {
        [_delegate datePickerView:self didSelectDate:selectedDate];
    }
    
    [self __hideWithAnimation:YES];
}

#pragma mark 显示
- (void)__showWithAnimation:(BOOL)animation {
    _visible = YES;
    
    UIView *spView = self.superview;
    CGFloat originY = CGRectGetHeight(spView.frame) - CGRectGetHeight(self.frame);
    if (animation) {
        [UIView animateWithDuration:PTXDURATION animations:^{
            self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
        }];
    }else {
        self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
    }
    
}

#pragma mark 隐藏
- (void)__hideWithAnimation:(BOOL)animation {
    _visible = NO;
    
    UIView *spView = self.superview;
    CGFloat originY = CGRectGetHeight(spView.frame);
    if (animation) {
        [UIView animateWithDuration:PTXDURATION animations:^{
            self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
        }];
    }else {
        self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
    }
    
}

#pragma mark 更新但前时间数组中的数据
- (void)updateCurrentDateArray {
    //获取当前选中时间。
    NSInteger currentYear = [[yearArray objectAtIndex:selectedYearRow] integerValue];
    NSInteger currentMonth = [[monthArray objectAtIndex:selectedMonthRow] integerValue];
    NSInteger currentDay = [[dayArray objectAtIndex:selectedDayRow] integerValue];
    NSInteger currentHour = [[hourArray objectAtIndex:selectedHourRow] integerValue];
    
    //更新时间数组中的数据。
    [self resetYearArray];
    [self resetMonthArrayWithYear:currentYear];
    [self resetDayArrayWithYear:currentYear month:currentMonth];
    [self resetHourArrayWithYear:currentYear month:currentMonth day:currentDay];
    [self resetMinuteArrayWithYear:currentYear month:currentMonth day:currentDay hour:currentHour];
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    switch (_datePickerViewShowModel) {
        case PTXDatePickerViewShowModelDefalut:
            return 5;
            break;
        case PTXDatePickerViewShowModelYearMonthDay:
            return 3;
            break;
        case PTXDatePickerViewShowModelYearMonthDayHour:
            return 4;
            break;
        case PTXDatePickerViewShowModelYearMonth:
            return 2;
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [yearArray count];
            break;
        case 1:
            return [monthArray count];
            break;
        case 2:
            return [dayArray count];
            break;
        case 3:
            return [hourArray count];
            break;
        case 4:
            return [minuteArray count];
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGFloat labelWidth = 0.0;
        switch (_datePickerViewShowModel) {
            case PTXDatePickerViewShowModelDefalut:
                labelWidth = CGRectGetWidth(pickerView.frame) / 5;
                break;
            case PTXDatePickerViewShowModelYearMonthDay:
                labelWidth = CGRectGetWidth(pickerView.frame) / 3;
                break;
            case PTXDatePickerViewShowModelYearMonthDayHour:
                labelWidth = CGRectGetWidth(pickerView.frame) / 4;
                break;
            case PTXDatePickerViewShowModelYearMonth:
                labelWidth = CGRectGetWidth(pickerView.frame) / 2;
                break;
        }
        
        pickerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, labelWidth, 30.0f)];
        pickerLabel.textColor = kRGBColor(90, 90, 90, 1);
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor whiteColor];
        pickerLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    
    switch (component) {
        case 0:
            pickerLabel.text = [NSString stringWithFormat:@"%@年", [yearArray objectAtIndex:row]];
            break;
        case 1:
            pickerLabel.text = [NSString stringWithFormat:@"%@月", [monthArray objectAtIndex:row]];
            break;
        case 2:
            pickerLabel.text = [NSString stringWithFormat:@"%@日", [dayArray objectAtIndex:row]];
            break;
        case 3:
            pickerLabel.text = [NSString stringWithFormat:@"%@时", [hourArray objectAtIndex:row]];
            break;
        case 4:
            pickerLabel.text = [NSString stringWithFormat:@"%@分", [minuteArray objectAtIndex:row]];
            break;
        default:
            break;
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            selectedYearRow = row;
            
            NSInteger selectedYear = [[yearArray objectAtIndex:row] integerValue]; //获取选择的年份。
            [self resetMonthArrayWithYear:selectedYear]; //重置月份。
            
            NSInteger selectedMonth = [[monthArray objectAtIndex:selectedMonthRow] integerValue]; //获取选择的月份。
            [self resetDayArrayWithYear:selectedYear month:selectedMonth]; //重置天数。
            
            if (_datePickerViewShowModel == PTXDatePickerViewShowModelDefalut) {
                NSInteger selectedDay = [[dayArray objectAtIndex:selectedDayRow] integerValue]; //获取选择的天数。
                [self resetHourArrayWithYear:selectedYear month:selectedMonth day:selectedDay]; //重置小时。
                
                NSInteger selectedHour = [[hourArray objectAtIndex:selectedHourRow] integerValue]; //获取选择的小时。
                [self resetMinuteArrayWithYear:selectedYear month:selectedMonth day:selectedDay hour:selectedHour]; //重置分钟。
                
            }else if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonthDayHour) {
                NSInteger selectedDay = [[dayArray objectAtIndex:selectedDayRow] integerValue]; //获取选择的天数。
                [self resetHourArrayWithYear:selectedYear month:selectedMonth day:selectedDay]; //重置小时。
            }
            
            [pickerView reloadAllComponents];
        }
            break;
        case 1:
        {
            selectedMonthRow = row;
            
            NSInteger selectedMonth = [[monthArray objectAtIndex:row]integerValue];
            NSInteger selectedYear = [[yearArray objectAtIndex:selectedYearRow] intValue];
            [self resetDayArrayWithYear:selectedYear month:selectedMonth]; //重置天数
            
            if (_datePickerViewShowModel == PTXDatePickerViewShowModelDefalut) {
                NSInteger selectedDay = [[dayArray objectAtIndex:selectedDayRow] integerValue]; //获取选择的天数。
                [self resetHourArrayWithYear:selectedYear month:selectedMonth day:selectedDay]; //重置小时。
                
                NSInteger selectedHour = [[hourArray objectAtIndex:selectedHourRow] integerValue]; //获取选择的小时。
                [self resetMinuteArrayWithYear:selectedYear month:selectedMonth day:selectedDay hour:selectedHour]; //重置分钟。
                
            }else if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonthDayHour) {
                NSInteger selectedDay = [[dayArray objectAtIndex:selectedDayRow] integerValue]; //获取选择的天数。
                [self resetHourArrayWithYear:selectedYear month:selectedMonth day:selectedDay]; //重置小时。
            }
            
            [pickerView reloadAllComponents];
        }
            break;
        case 2:
        {
            selectedDayRow = row;
            
            
            NSInteger selectedDay = [[dayArray objectAtIndex:row] integerValue];
            NSInteger selectedYear = [[yearArray objectAtIndex:selectedYearRow] integerValue];
            NSInteger selectedMonth = [[monthArray objectAtIndex:selectedMonthRow] integerValue];
            if (_datePickerViewShowModel == PTXDatePickerViewShowModelDefalut) {
                [self resetHourArrayWithYear:selectedYear month:selectedMonth day:selectedDay]; //重置小时。
                
                NSInteger selectedHour = [[hourArray objectAtIndex:selectedHourRow] integerValue]; //获取选择的小时。
                [self resetMinuteArrayWithYear:selectedYear month:selectedMonth day:selectedDay hour:selectedHour]; //重置分钟。
                
            }else if (_datePickerViewShowModel == PTXDatePickerViewShowModelYearMonthDayHour) {
                [self resetHourArrayWithYear:selectedYear month:selectedMonth day:selectedDay]; //重置小时。
            }
            
            [pickerView reloadAllComponents];
        }
            break;
        case 3:
        {
            selectedHourRow = row;
            
            NSInteger selectedHour = [[hourArray objectAtIndex:row] integerValue];
            NSInteger selectedYear = [[yearArray objectAtIndex:selectedYearRow] integerValue];
            NSInteger selectedMonth = [[monthArray objectAtIndex:selectedMonthRow] integerValue];
            NSInteger selectedDay = [[dayArray objectAtIndex:selectedDayRow] integerValue];
            if (_datePickerViewShowModel == PTXDatePickerViewShowModelDefalut) {
                [self resetMinuteArrayWithYear:selectedYear month:selectedMonth day:selectedDay hour:selectedHour]; //重置分钟。
                
            }
            
            [pickerView reloadAllComponents];
        }
            break;
        case 4:
            break;
        default:
            break;
    }
}

#pragma mark - Setter
- (void)setMinYear:(NSInteger)minYear {
    NSAssert(minYear < _maxYear, @"最小年份必须小于最大年份！");
    
    _minYear = minYear;
    
    [self resetYearArray];
    [datePickerView reloadAllComponents];
}

- (void)setMaxYear:(NSInteger)maxYear {
    NSAssert(maxYear > _minYear, @"最大年份必须大于最小年份！");
    NSAssert(_datePickerViewDateRangeModel == PTXDatePickerViewDateRangeModelCustom, @"当前模式下只允许显示当前系统最大时间，所以不允许设置最大年份！");
    
    //更新最大值。
    _maxYear = maxYear;
    
    [self updateCurrentDateArray];
    [datePickerView reloadAllComponents];
}

- (void)setDatePickerViewShowModel:(PTXDatePickerViewShowModel)datePickerViewShowModel {
    _datePickerViewShowModel = datePickerViewShowModel;
    [datePickerView reloadAllComponents];
    [self __initTitleView];
    
}

- (void)setDatePickerViewDateRangeModel:(PTXDatePickerViewDateRangeModel)datePickerViewDateRangeModel {
    PTXDatePickerViewDateRangeModel tempModel = datePickerViewDateRangeModel;
    _datePickerViewDateRangeModel = datePickerViewDateRangeModel;
    
    if (tempModel == PTXDatePickerViewDateRangeModelCurrent) {
        //更新时间最大值为当前系统时间。
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
        NSDateComponents *currentDateComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
        
        _maxYear = [currentDateComponents year];
        maxMonth = [currentDateComponents month];
        maxDay = [currentDateComponents day];
        maxHour = [currentDateComponents hour];
        maxMinute = [currentDateComponents minute];
        
    }else if (tempModel == PTXDatePickerViewDateRangeModelCustom) {
        //年份不变，其它更新为最大值。
        maxMonth = 12;
        maxDay = 31;
        maxHour = 23;
        maxMinute = 59;
    }
    
    [self updateCurrentDateArray];
    [datePickerView reloadAllComponents];
}

@end
