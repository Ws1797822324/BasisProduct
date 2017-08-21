//
//  ContactsCell.h
//  Product
//
//  Created by Sen wang on 2017/8/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactsModel;
@interface ContactsCell : UITableViewCell

/** 组员模型对象 */
@property (nonatomic, strong) ContactsModel *model;

@end
