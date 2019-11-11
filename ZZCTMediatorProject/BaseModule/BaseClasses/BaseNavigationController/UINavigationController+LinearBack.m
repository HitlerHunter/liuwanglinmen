//
//  UINavigationController+LinearBack.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/23.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UINavigationController+LinearBack.h"

@implementation UINavigationController (LinearBack)

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
              linearBackId:(NSString *)linearBackId{
    
    [self pushViewController:viewController animated:animated];
    
    [viewController.linearBackDictionary setValue:@(YES) forKey:linearBackId];
    
}
@end
