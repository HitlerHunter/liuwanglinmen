//
//  CYLTabBarControllerConfig.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/6.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CYLTabBarControllerConfig.h"
#import "CTMediator+ModuleMainActions.h"
#import "CTMediator+ModuleMineActions.h"
#import "CTMediator+ModuleShareActions.h"
#import "CTMediator+Level.h"

@implementation CYLTabBarControllerConfig

+ (CYLTabBarController *)tabBarController {


    SDBaseNavigationController * firstNav = [[CTMediator sharedInstance] CTMediator_NavForMain];
    SDBaseNavigationController * shareNav = [[CTMediator sharedInstance] CTMediator_NavForShare];
    
    UIViewController *level = [[CTMediator sharedInstance] CTMediator_LevelController];
    SDBaseNavigationController *levelNav = [[SDBaseNavigationController alloc] initWithRootViewController:level];
    levelNav.navigationBar.shadowImage = [UIImage new];
    SDBaseNavigationController * mineNav = [[CTMediator sharedInstance] CTMediator_NavForMine];
    
    NSArray * tabBarItemsAttributes = [self tabBarItemsAttributes];
    NSArray * viewControllers = @[firstNav,shareNav,levelNav,mineNav];
    
    CYLTabBarController * tabBarController = [[CYLTabBarController alloc] init];
    
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    tabBarController.viewControllers = viewControllers;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rgb(101,101,101), NSForegroundColorAttributeName,
                                                       Font_PingFang_SC_Medium(10),NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:rgb(255,82,0), NSForegroundColorAttributeName,
                                                       Font_PingFang_SC_Medium(10),NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBarTintColor:LZWhiteColor];
    [UITabBar appearance].translucent = NO;
    
    return tabBarController;
}


+ (NSArray *)tabBarItemsAttributes {
    NSDictionary * tabBarItem1Attribute = @{
                                            CYLTabBarItemTitle : @"首页",
                                            CYLTabBarItemImage : @"shouye_normal",
                                            CYLTabBarItemSelectedImage : @"shouye_selected"
                                            };
    NSDictionary * tabBarItem2Attribute = @{
                                            CYLTabBarItemTitle : @"推广",
                                            CYLTabBarItemImage : @"share_normal",
                                            CYLTabBarItemSelectedImage : @"share_selected"
                                            };
    NSDictionary * tabBarItem3Attribute = @{
                                            CYLTabBarItemTitle : @"升级",
                                            CYLTabBarItemImage : @"levelup_normal",
                                            CYLTabBarItemSelectedImage : @"levelup_selected"
                                            };
//    NSDictionary * tabBarItem3Attribute = @{
//                                            CYLTabBarItemTitle : @"升级",
//                                            CYLTabBarItemImage : @"home_upgrade_ash",
//                                            CYLTabBarItemSelectedImage : @"home_upgrade"
//                                            };
    NSDictionary * tabBarItem4Attribute = @{
                                            CYLTabBarItemTitle : @"我的",
                                            CYLTabBarItemImage : @"wode_normal",
                                            CYLTabBarItemSelectedImage : @"wode_selected"
                                            };
//    NSArray * tarBarItemsAttrbutes = @[tabBarItem1Attribute, tabBarItem2Attribute, tabBarItem3Attribute, tabBarItem4Attribute];
    NSArray * tarBarItemsAttrbutes = @[tabBarItem1Attribute,tabBarItem2Attribute,tabBarItem3Attribute,tabBarItem4Attribute];
    
    return tarBarItemsAttrbutes;
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
+ (void)customizeTabBarAppearance {
    
        //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
        // set the text color for unselected state
        // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
        // set the text color for selected state
        // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
        // set the text Attributes
        // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
        // Set the dark color to selected tab (the dimmed background)
        // TabBarItem选中后的背景颜色
    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:26 / 255.0 green:163 / 255.0 blue:133 / 255.0 alpha:1] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 5.0f, 49) withCornerRadius:0]];
    
        // set the bar background color
        // 设置背景图片
        // UITabBar *tabBarAppearance = [UITabBar appearance];
        // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_ios7"]];
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
        // Begin a new image that will be the new image with the rounded corners
        // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
        // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
        // Draw your image
    [image drawInRect:rect];
    
        // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
        // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    return image;
}
@end
