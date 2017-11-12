//
//  UserInfoTool.m
//  Product
//
//  Created by Sen wang on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserInfoTool.h"

#define XXAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.archive"]

@implementation UserInfoTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(UserInfo *)account
{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:XXAccountPath];
}

/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+ (UserInfo *)account
{
    // 加载模型
    UserInfo *account = [NSKeyedUnarchiver unarchiveObjectWithFile:XXAccountPath];
    return account;
}
@end
