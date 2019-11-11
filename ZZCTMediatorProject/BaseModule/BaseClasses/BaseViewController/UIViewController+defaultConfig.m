//
//  UIViewController+defaultConfig.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/11.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "UIViewController+defaultConfig.h"

@implementation UIViewController (defaultConfig)

-(CGFloat)base_statusbarHeight{
        //状态栏高度
    return LZApp.shareInstance.app_statusBarHeight;
}

-(CGFloat)base_navigationbarHeight{
        //导航栏高度+状态栏高度
    return LZApp.shareInstance.app_navigationBarHeight;
}

-(CGFloat)base_tabbarHeight{
        //Tabbar高度
    return LZApp.shareInstance.app_tabbarHeight;
}

@end
