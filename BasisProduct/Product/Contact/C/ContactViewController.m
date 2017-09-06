//
//  ContactViewController.m
//  Product
//
//  Created by Sen wang on 2017/8/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ContactViewController.h"

#import "ContactContentViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        [self configStyle];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聊一聊";

   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:nil highImage:nil target:self action:@selector(leftAction) withTitle:@"单聊"];
    
   
    
    // Do any additional setup after loading the view.
}

-(void) leftAction {
    ContactContentViewController *contactContentVC = [[ContactContentViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"1797822325"];

    
    contactContentVC.title = @"名字";
    
    [self.navigationController pushViewController:contactContentVC animated:YES];
}



 #pragma mark - 配置格式
-(void) configStyle {
    [XXHelper deleteExtraCellLine:self.conversationListTableView];
    
    self.view.backgroundColor = kAllRGB;

    // 置顶会话的Cell背景颜色
//    self.topCellBackgroundColor = [UIColor redColor];
    
    // 列表为空时显示的View
    //    UIView * emptyConversationView = [[UIView alloc]initWithFrame:kFrame(0, 0, kScreenWidth, kScreenHeight)];
    //    emptyConversationView.backgroundColor = [UIColor orangeColor];
    //    self.emptyConversationView = emptyConversationView;

    
    //  列表中需要显示的会话类型
    self.displayConversationTypeArray = @[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CUSTOMERSERVICE),@(ConversationType_SYSTEM)];
    
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[
                                          @(ConversationType_CUSTOMERSERVICE),@(ConversationType_SYSTEM)
                                          ]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击Cell
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    
  
    //聚合会话类型，此处自定设置。
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        
        ContactViewController *temp =
        [[ContactViewController alloc] init];
        NSArray *array = [NSArray
                          arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
        [temp setDisplayConversationTypes:array];
        [temp setCollectionConversationType:nil];
        temp.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:temp animated:YES];
    } else if(conversationModelType == ConversationType_PRIVATE) {   // 单聊
    ContactContentViewController *contactContentVC = [[ContactContentViewController alloc] init];
    //聊天界面的聊天类型
    contactContentVC.conversationType = model.conversationType;
    //需要打开和谁聊天的会话界面,和谁聊天其实是通过TargetId来联系的。
    contactContentVC.targetId = model.targetId;
    contactContentVC.title = @"名字";
    
    [self.navigationController pushViewController:contactContentVC animated:YES];
    }
}


-(void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    RCConversationModel * model = self.conversationListDataSource[indexPath.row];
    if ((model.conversationType =ConversationType_PRIVATE)) {
        RCConversationCell * conversationCell = (RCConversationCell *) cell;
        
        conversationCell.conversationTitle.textColor = [UIColor redColor];
    }
    
}


@end
