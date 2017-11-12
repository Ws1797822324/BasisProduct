//
//  AppDelegate.m
//  Product
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+Extension.h"
#import "CYLTabBarController.h"

#define RCAppKey @"0vnjpoad0g8fz"
#define RCtoken @"AJLfRM5IBMwb8gajqjil3yaS4WJX8IK1A/g1cn5DAsx1HxHCQHzGWEhRKJ7an6HMs6mkFZZreMCic+MsIPorVQHm8hFZ2dxo"


@interface AppDelegate () <RCIMUserInfoDataSource, RCIMReceiveMessageDelegate, RCIMConnectionStatusDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    PublicSection * hhh = [PublicSection shareInstance];
    hhh.token = @"我是 token";
    [self setRootControllor];
    [self settingIQKeyboard];

    [[RCIM sharedRCIM]initWithAppKey:RCAppKey];  //24

    
    
    [[RCIM sharedRCIM] setEnableMessageAttachUserInfo:YES];
    
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
//    连接状态的监听器
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)];
    
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    //  设置头像是方的
     [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_RECTANGLE;
    
    
    
    
    
    
    
    
    
    
    
    [[RCIM sharedRCIM]connectWithToken:RCtoken success:^(NSString *userId) { // 24



    NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        [RCIM sharedRCIM].userInfoDataSource = self;
    } error:^(RCConnectErrorCode status) {
        
            NSLog(@"登陆的错误码为:%ld", (long)status);
        
    } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
              return YES;
}


-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    
    if ([userId isEqualToString:@"1797822325"]) {
        RCUserInfo * userinfo = [[RCUserInfo alloc] init];
        userinfo.name = @"24 -> 25";
        userinfo.userId = userId;
        userinfo.portraitUri = @"http://58pic.ooopic.com/58pic/13/20/44/96758PICveN.jpg";
        return completion(userinfo);
    }
    return completion(nil);
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
