//
//  UIView+UIViewController.h
//  Youdoneed
//
//  Created by 曾立志 on 2017/6/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewController)

/**类似ninapagerView 中，去最上层的viewController*/
@property (nullable, nonatomic, readonly, strong) UIViewController *topViewController;

@end
