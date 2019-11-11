//
//  SDBaseNavigationController.m
//  GSD_WeiXin(wechat)
//
//  Created by aier on 16/2/10.
//  Copyright © 2016年 GSD. All rights reserved.
//


#import "SDBaseNavigationController.h"

@interface SDBaseNavigationController ()

@end

@implementation SDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count == 1) {
        UIViewController *vc = self.viewControllers[0];
        vc.hidesBottomBarWhenPushed = YES;
        [super pushViewController:viewController animated:animated];
        vc.hidesBottomBarWhenPushed = NO;

        return;
    }
    self.visibleViewController.hidesBottomBarWhenPushed = YES;

    [super pushViewController:viewController animated:animated];

}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    
    if (viewControllers.count == 1) {
        UIViewController *vc = viewControllers[0];
        vc.hidesBottomBarWhenPushed = YES;
        [super setViewControllers:viewControllers animated:animated];
        vc.hidesBottomBarWhenPushed = NO;

        return;
    }

    self.visibleViewController.hidesBottomBarWhenPushed = YES;
    
    [super setViewControllers:viewControllers animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
    
}
@end
