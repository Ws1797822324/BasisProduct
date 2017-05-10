//
//  CFFlowButtonView.h
//  CFFlowButtonView
//

//

#import <UIKit/UIKit.h>

@interface CFFlowButtonView : UIView

/**
 *  存放需要显示的button
 */
@property (nonatomic, strong) NSMutableArray *buttonList;

/**
 *  通过传入一组按钮初始化CFFlowButtonView
 *
 *  @param buttonList 按钮数组
 *
 *  @return CFFlowButtonView对象
 */
- (instancetype)initWithButtonList:(NSMutableArray *)buttonList;

@end
