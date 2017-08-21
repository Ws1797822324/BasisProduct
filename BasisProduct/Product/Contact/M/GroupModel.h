//
//  GroupModel.h
//  Product
//
//  Created by Sen wang on 2017/8/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

/** 分组ID */
@property (nonatomic, copy) NSString *groupId;
/** 分组名称 */
@property (nonatomic, copy) NSString *groupName;
/** 分组类型(1表示未分组, 2表示自定义分组) */
@property (nonatomic, assign) NSInteger groupType;
/** 成员个数(患者个数) */
@property (nonatomic, assign) NSInteger memberNum;
/** 分组下的好友列表 */
@property (nonatomic, strong) NSArray *contacts;


@end
