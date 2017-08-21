//
//  ContactsModel.h
//  Product
//
//  Created by Sen wang on 2017/8/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsModel : NSObject

/** 用户ID */
@property (nonatomic, copy) NSString *ID;
/** 头像 */
@property (nonatomic, copy) NSString *headImg;
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 活动时间(表示与该联系人的最后交流时间) */
@property (nonatomic, copy) NSString *activeTime;


@end
