//
//  AppMessage+LocalNotice.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AppMessage+LocalNotice.h"
#import <UserNotifications/UserNotifications.h>

@implementation AppMessage (LocalNotice)

- (void)showMessageWithDic:(NSDictionary *)dic{
    MineMessageModel *model = [MineMessageModel mj_objectWithKeyValues:dic];
    if (!IsNull(model.Id)) {
            // 1.创建通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = model.title;
//        content.subtitle = @"测试通知";
//        content.body = @"来自徐不同的简书";
        content.badge = @1;

//        content.launchImageName = @"AppIcon";
            // 2.设置声音
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
        content.sound = sound;
        
            // 3.触发模式
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        
            // 4.设置UNNotificationRequest
        NSString *requestIdentifer = @"MineMessageModel";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
        
            //5.把通知加到UNUserNotificationCenter, 到指定触发点会被触发
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
        
    }
}

@end
