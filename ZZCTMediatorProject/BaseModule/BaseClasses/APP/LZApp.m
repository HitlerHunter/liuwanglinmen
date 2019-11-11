//
//  LZApp.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/11.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "LZApp.h"

static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;

    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

@implementation LZApp

+ (void)launch{
    [LZApp shareInstance];
}

+ (LZApp *)shareInstance{
    static LZApp *app;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (app == nil) {
            app = [[LZApp alloc]init];
            [app configInit];
        }
    });
    return app;
}

- (void)configInit{
    UINavigationController *nav = [UINavigationController new];
    self.app_navigationBarHeight = nav.navigationBar.frame.size.height + self.app_statusBarHeight;
    
    if(isIPhoneXSeries()){
        self.app_tabbarHeight = 83.0;
    }else{
        self.app_tabbarHeight = 49.0;
    }
    
}

-(CGFloat)app_statusBarHeight{
        //状态栏高度
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

-(CGFloat)app_navigationBarHeight{
        //导航栏高度+状态栏高度
    return _app_navigationBarHeight;
}

-(CGFloat)app_tabbarHeight{
        //Tabbar高度
    return _app_tabbarHeight;
}

@end
