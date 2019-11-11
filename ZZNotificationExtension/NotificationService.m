//
//  NotificationService.m
//  ZZNotificationExtension
//
//  Created by zenglizhi on 2019/7/17.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "NotificationService.h"
#import "BPAudioManager.h"
//#import "UserManager.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
        // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    NSDictionary *userInfo = self.bestAttemptContent.userInfo;
    NSString *contentStr = userInfo[@"jsonData"];
    
    NSData *jsonData = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!contentStr) {
        
        return;
    }
    NSError *err;
    NSDictionary *extrasParam = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
    if (extrasParam) {
        NSUserDefaults *myDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.liuwanshangjia1"];
        BOOL isCloseTTS = [myDefaults boolForKey:@"isCloseTTS"];
        
            // Modify the notification content here...
//        self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [1]", self.bestAttemptContent.title];
        
        if (!isCloseTTS) {
            NSString *money = extrasParam[@"orderAmt"];
            [[BPAudioManager sharedPlayer] willPlayWithMoney:money];
            
//            self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [2]", self.bestAttemptContent.title];
        }
    }
    
    
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
