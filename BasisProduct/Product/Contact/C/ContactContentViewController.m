//
//  ChatDetails ViewController.m
//  Product
//
//  Created by Sen wang on 2017/8/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ContactContentViewController.h"

@interface ContactContentViewController ()

@end

@implementation ContactContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.conversationMessageCollectionView.backgroundColor = kAllRGB;
//    self.view.backgroundColor = [UIColor colorWithPatternImage:kImageNamed(@"BJ")]; 背景图
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - cell 即将显示
-(void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell isMemberOfClass:[RCTextMessageCell class]]) {
        
        RCTextMessageCell * textMsgCell = (RCTextMessageCell *) cell;
        UILabel * textMasLabel =  (UILabel *)textMsgCell.textLabel;
        textMasLabel.textColor = kHexColor(@"#FF7F50");
    }
}


/*!
 MARK: --  点击Cell中头像的回调
 
 @param userId  点击头像对应的用户ID
 */
- (void)didTapCellPortrait:(NSString *)userId{
    
    NSLog(@"点击了头像");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
