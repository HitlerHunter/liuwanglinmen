//
//  LevelUpAreaServerController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelUpAreaServerController : SDBaseViewController

@property (nonatomic, strong) NSString *money;

+ (LevelUpAreaServerController *)showAreaServerWithController:(UIViewController *)superController;
@end

NS_ASSUME_NONNULL_END
