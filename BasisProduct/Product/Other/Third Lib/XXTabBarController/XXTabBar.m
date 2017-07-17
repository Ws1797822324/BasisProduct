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
#import "PublishViewController.h"

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
        [btn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"post_normal_click"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"post_normal_click"] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(specialClick) forControlEvents:UIControlEventTouchUpInside];

        [btn sizeToFit];
        

        
        _specialButton = btn;
        
        [self addSubview:_specialButton];
        
    }
    return _specialButton;
}

-(void) specialClick {

    if (self.delegateAction && [self.delegateAction respondsToSelector:@selector(tabBarDidClickAtCenterButton:)]) {
        [self.delegateAction tabBarDidClickAtCenterButton:self];
    }

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

- (void)layoutSubviews {
    
    [super layoutSubviews];
    // 标记按钮是否已经添加过监听器,避免循环添加事件
    static BOOL added = NO;

    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    int count = (int)self.tabBarItems.count ;
    CGFloat itemY = 0;
    CGFloat itemW = w / (self.subviews.count + 1);
    CGFloat itemH = h;
 

    self.specialButton.centerX = w * 0.5;
    self.specialButton.centerY = h * 0.3;

    
    
    for (int index = 0; index < count ; index++) {

        XXTabBarItem *tabBarItem = self.tabBarItems[index];
        if (![tabBarItem isKindOfClass:[UIControl class]] || tabBarItem == self.specialButton) continue;
        tabBarItem.tag = index;
        
        CGFloat itemX =  ((index > (count/ 2) - 1) ? (index + 1) : index) * itemW;

        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);

        if (added == NO) {
            // 监听按钮点击
            [tabBarItem addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    added = YES;

    }

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
   
    
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.specialButton];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.specialButton pointInside:newP withEvent:event]) {
            return self.specialButton;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

// 让所有的控制器都能接到通知
- (void)buttonClick
{
    // 发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XXTabBarDidSelectNotification" object:nil userInfo:nil];
}

@end
