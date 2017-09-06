//
//  ChoiceSuppliersCell.m
//  Product
//
//  Created by Sen wang on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChoiceSuppliersOrPurchaserCell.h"


#import "SDTagsView.h"

@interface ChoiceSuppliersOrPurchaserCell () <IMJIETagViewDelegate>


@end

@implementation ChoiceSuppliersOrPurchaserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    kViewRadius(_Identity_tag_label, 3);

    NSArray *array = @[ @"曹古营散养野生鲜猪肉", @"内蒙古野生新鲜牛肉", @"更多" ];
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 5;
    frame.tagsMargin = 3;
    frame.tagsLineSpacing = 3;
    frame.tagsArray = array;

    
        [_commodity_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset( frame.tagsHeight);
        }];
    

    IMJIETagView *tagView =
        [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 0, _commodity_view.width + 20, frame.tagsHeight)];
    tagView.backgroundColor = [UIColor whiteColor];
    tagView.clickbool = YES;
    tagView.borderSize = 0.5;
    tagView.clickborderSize = 0.5;
    tagView.clickBackgroundColor = [UIColor whiteColor];
    tagView.clickTitleColor = kHexColor(@"#009900");
    tagView.defaultBorderColor = kHexColor(@"#66CC00");
    tagView.clickStart = 0; // 单选
    tagView.clickString = @"更多";
    tagView.tagsFrame = frame;


    tagView.delegate = self;
    [self.commodity_view addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.offset(0);
        make.width.equalTo(_commodity_view.mas_width);
        make.height.offset(frame.tagsHeight);
    }];
}

- (void)IMJIETagView:(NSArray *)tagArray {

    if ([tagArray[0]intValue] == 2) {

        
        UIView * tempView = [[UIView alloc]initWithFrame:kFrame(0, 0, kScreenWidth, kScreenHeight)];
        tempView.backgroundColor = [UIColor whiteColor];
        
        
        NSLog(@"kk -- kk %ld",(long)index);
        
        SDTagsView *sdTagsView =[SDTagsView sdTagsViewWithTagsArr:@[ @"白菜", @"芹菜", @"空心菜",@"玉米",@"大麦",@"桑葚",@"猪肉",@"粉条",@"时间",@"鸡肉丝",@"白菜", @"芹菜", @"空心菜",@"玉米",@"大麦",@"桑葚",@"猪肉",@"粉条",@"时间",@"鸡肉丝",@"白菜", @"芹菜", @"空心菜",@"玉米",@"大麦",@"桑葚",@"猪肉",@"粉条",@"时间",@"鸡肉丝",@"白菜", @"芹菜", @"空心菜",@"玉米",@"大麦",@"桑葚",@"猪肉",@"粉条",@"时间",@"鸡肉丝"]];
        
        
        
        [tempView addSubview:sdTagsView];
        
        
        KLCPopup *popView =[KLCPopup popupWithContentView:tempView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeShrinkOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:YES];
        
        KLCPopupLayout  popLayout = (KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter));
        
        [popView showWithLayout:popLayout];
        

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
