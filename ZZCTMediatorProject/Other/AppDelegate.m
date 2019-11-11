//
//  AppDelegate.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/8/21.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import "CTMediator+CTMediatorModuleLoginActions.h"
#import "YiDaoViewController.h"
#import <IQKeyboardManager.h>

#import <JPush/JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
//#import <AudioToolbox/AudioServices.h>
#endif
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMShare/UMShare.h>    // 分享组件
#import "BPAudioManager.h"
#import <AvoidCrash.h>
#import "CTMediator+ModuleBookActions.h"
#import "CTMediator+ModuleMainActions.h"
#import "AppPayManager.h"

#import "LFUpDateLicenseManger.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
        //防止崩溃
    [AvoidCrash makeAllEffective];
    NSArray *noneSelClassStrings = @[
                                     @"NSString",
                                     @"NSNull",
                                     @"NSNumber",
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    [NSObject avoidCrashExchangeMethodIfDealWithNoneSel:YES];
    [NSString avoidCrashExchangeMethod];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [LaunchViewController new];
    
    [self configJpush];
    [JPUSHService setupWithOption:launchOptions appKey:JPush_AppKey channel:@"apple store" apsForProduction:YES];
    [WXApi registerApp:WeChat_AppID];
    
        //活体检测 设置动态更新license文件
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *pathLicense = [[NSBundle mainBundle] pathForResource:@"LinkfaceID_Liveness" ofType:@"lic"];
    [LFUpDateLicenseManger loadLicensePath:pathLicense cachePath:[NSString stringWithFormat:@"%@/LFLivenessCacae",docDir]];

    
    [self configZZNetWork];
        //检查v
    [AppCenter getAppInfo];
    
    [UMConfigure initWithAppkey:@"5ab0ce5a8f4a9d2f6b000026" channel:@"App Store"];
    [UMConfigure setLogEnabled:NO];
    [self setupUSharePlatforms];
    
    BOOL willShowYD = [[NSUserDefaults standardUserDefaults] boolForKey:@"willShowYD"];
    NSString *YDVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"YDVersion"];
    
//    willShowYD = YES;
    if (willShowYD || ![YDVersion isEqualToString:AppVersion]) {
        _window.rootViewController = [YiDaoViewController new];
    }else{
        
        [[UserManager shareInstance] refreshToken:^(BOOL isTokenValid) {
            if (isTokenValid) {
                [AppCenter toTabBarController];
            }else{
                [[CTMediator sharedInstance] CTMediator_showLoginViewController];
            }
        }];
        
    }
    
    [[UINavigationBar appearance] setBarTintColor:LZWhiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [self configKeyoard];
    
    [self configHud];
    
    
    return YES;
}

- (void)configJpush{
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
}


- (void)configKeyoard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f;
}

- (void)configHud{
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setMaximumDismissTimeInterval:3];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

- (void)configZZNetWork{
    ZZNetWorker.woker.zz_defaultRequest(^(ZZNetWorker *worker) {
        worker.zz_log(YES);
        worker.baseUrl = BaseURL;
        worker.willHandlerParam = YES;
        [worker.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        if (CurrentUser.access_token) {
            NSString *access_token = [NSString stringWithFormat:@"Bearer %@",CurrentUser.access_token];
            worker.Authorization = access_token;
        }
        
    }).zz_handlerParam(^id(id param,ZZNetWorker *worker) {
        
        if ([param isKindOfClass:[NSDictionary class]] && worker.willHandlerParam) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:param];
            [dic setSafeObject:@"6w" forKey:@"appId"];
            param = dic;
        }
        return param;
    });
    
}

- (void)setupUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx1ecba433dea3efa8" appSecret:@"c13423b4593fe87947de6992fd441841" redirectURL:nil];
    
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [UIApplication.sharedApplication beginReceivingRemoteControlEvents];
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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    if ([url.absoluteString hasPrefix:WeChat_AppID]) {
        return [WXApi handleOpenURL:url delegate:[AppPayManager shareInstance]];
    }
    
    return YES;
}

#pragma mark - jpush
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
        /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken]; //如想获得，devicetoken直接转换成字符串即可
        //获得注册后的regist_id，此值一般传给后台做推送的标记用,先存储起来
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (registrationID.length) {
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"JPUSHServiceRegisterid"];
            SDLog(@"\n\n JPUSHService : \n %@ \n\n",registrationID);
        }
    }];
}

#pragma mark- JPUSHRegisterDelegate
    // iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
        // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])        {
        [JPUSHService handleRemoteNotification:userInfo];

        SDLog(@"推送：%@",userInfo);
        
        NSString *mutable_content = userInfo[@"aps"][@"mutable-content"];
        if (mutable_content.integerValue == 1) {
            //企业签名 不能用 Extension
            if (![AppCenter checkAppIsToHoc]) {
                //已经走 Extension 了
                completionHandler(UNNotificationPresentationOptionAlert);
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                return;
            }
        }
            //语音播报
        NSString *contentStr = userInfo[@"jsonData"];

        NSData *jsonData = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (!contentStr) {
            completionHandler(UNNotificationPresentationOptionAlert);
            return;
        }
        
        NSError *err;
        NSDictionary *extrasParam = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        SDLog(@"\n\n jsonData:\n%@\n\n",extrasParam);
        if (!extrasParam) {
            completionHandler(UNNotificationPresentationOptionNone);
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            return;
        }
        //{"jsonData":"{\"orderAmt\":0.01,\"transNo\":\"666349153990742016\"}"}
        //{"orderAmt":0.01,"transNo":"666349153990742016"}
        if (!CurrentUser.isCloseTTS) {
            NSString *money = extrasParam[@"orderAmt"];
            [[BPAudioManager sharedPlayer] willPlayWithMoney:money];
        }else{
                //关闭语音播报的推送
            completionHandler(UNNotificationPresentationOptionSound);
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            return;
        }
        
    }
    
    completionHandler(UNNotificationPresentationOptionAlert |UNNotificationPresentationOptionBadge| UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

    // iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:  [UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            
                //语音播报
            NSString *contentStr = userInfo[@"jsonData"];
            
            NSData *jsonData = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
            
            if (!contentStr) {
                
                return;
            }
            NSError *err;
            NSDictionary *extrasParam = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:&err];
            SDLog(@"\n\n extrasParam:\n%@\n\n",extrasParam);
            if (!extrasParam) {
                completionHandler(UNNotificationPresentationOptionBadge);
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                return;
            }
            
            NSString *ordId = extrasParam[@"transNo"];
            
            if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
                UINavigationController *nav = [(UITabBarController *)self.window.rootViewController selectedViewController];
                if ([nav isKindOfClass:[UINavigationController class]]) {
                    [[CTMediator sharedInstance] CTMediator_ShowOrdDetailWithOrdID:ordId nav:nav];
                }
            }
        }
    } else {
            // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
}

@end
