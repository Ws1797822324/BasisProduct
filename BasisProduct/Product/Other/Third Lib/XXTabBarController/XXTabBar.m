//
//  LCTabBar.m
//
//  Product
//
//  Created by Sen wang on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXTabBar.h"
#import "XXTabBarItem.h"

@interface XXTabBar ()

@property (nonatomic, weak) UIButton *specialButton;

@end

@implementation XXTabBar

- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        
        _tabBarItems = [[NSMutableArray alloc] init];
    }
    return _tabBarItems;
}
- (UIButton *)specialButton
{
    if (_specialButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(specialClick) forControlEvents:UIControlEventTouchUpInside];
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        
        _specialButton = btn;
        
        [self addSubview:_specialButton];
        
    }
    return _specialButton;
}

-(void) specialClick {
    UIViewController *publish = [[UIViewController alloc] init];
    publish.view.backgroundColor = [UIColor yellowColor];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
}
- (void)addTabBarItem:(UITabBarItem *)item {
    
    XXTabBarItem *tabBarItem = [[XXTabBarItem alloc] initWithItemImageRatio:self.itemImageRatio];
    
    tabBarItem.badgeTitleFont         = self.badgeTitleFont;
    tabBarItem.itemTitleFont          = self.itemTitleFont;
    tabBarItem.itemTitleColor         = self.itemTitleColor;
    tabBarItem.selectedItemTitleColor = self.selectedItemTitleColor;
    
    tabBarItem.tabBarItemCount = self.tabBarItemCount;
    
    tabBarItem.tabBarItem = item;
    
    [tabBarItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabBarItem];
    
    [self.tabBarItems addObject:tabBarItem];
    
    if (self.tabBarItems.count == 1) {
        
        [self buttonClick:tabBarItem];
    }
}

- (void)buttonClick:(XXTabBarItem *)tabBarItem {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        
        [self.delegate tabBar:self didSelectedItemFrom:self.selectedItem.tabBarItem.tag to:tabBarItem.tag];
    }
    
    self.selectedItem.selected = NO;
    self.selectedItem = tabBarItem;
    self.selectedItem.selected = YES;
}

#pragma mark - 有特殊的 item  用下面的布局

//- (void)layoutSubviews {
//    
//    [super layoutSubviews];
//    // 标记按钮是否已经添加过监听器,避免循环添加事件
//    static BOOL added = NO;
//
//    CGFloat w = self.frame.size.width;
//    CGFloat h = self.frame.size.height;
//    
//    int count = (int)self.tabBarItems.count ;
//    CGFloat itemY = 0;
//    CGFloat itemW = w / (self.subviews.count + 1);
//    CGFloat itemH = h;
// 
//    self.specialButton.center = CGPointMake(w * 0.5, h * 0.5);
//
//    for (int index = 0; index < count ; index++) {
//
//        LCTabBarItem *tabBarItem = self.tabBarItems[index];
//        if (![tabBarItem isKindOfClass:[UIControl class]] || tabBarItem == self.specialButton) continue;
//        tabBarItem.tag = index;
//        
//        CGFloat itemX =  ((index > (count/ 2) - 1) ? (index + 1) : index) * itemW;
//
//        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
//
//        if (added == NO) {
//            // 监听按钮点击
//            [tabBarItem addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
//    added = YES;
//
//    }

#pragma mark - 没有特殊的 item  用下面的布局

- (void)layoutSubviews {

    [super layoutSubviews];
    // 标记按钮是否已经添加过监听器,避免循环添加事件
    static BOOL added = NO;

    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;

    int count = (int) self.tabBarItems.count;
    CGFloat itemY = 0;
    CGFloat itemW = w / self.subviews.count;
    CGFloat itemH = h;

    for (int index = 0; index < count; index++) {

        XXTabBarItem *tabBarItem = self.tabBarItems[index];
        tabBarItem.tag = index;
        CGFloat itemX = index * itemW;
        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
        if (added == NO) {
            // 监听按钮点击
            [tabBarItem addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    added = YES;

}

// 让所有的控制器都能接到通知
- (void)buttonClick
{
    // 发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XXTabBarDidSelectNotification" object:nil userInfo:nil];
}

@end
