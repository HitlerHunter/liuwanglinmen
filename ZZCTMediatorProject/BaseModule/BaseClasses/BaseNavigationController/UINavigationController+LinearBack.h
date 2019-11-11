//
//  UINavigationController+LinearBack.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/23.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LinearBack.h"

#define PushIdController(vc,Id) [self.navigationController pushViewController:vc animated:YES linearBackId:Id]
@interface UINavigationController (LinearBack)

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
              linearBackId:(NSString *)linearBackId;
@end
