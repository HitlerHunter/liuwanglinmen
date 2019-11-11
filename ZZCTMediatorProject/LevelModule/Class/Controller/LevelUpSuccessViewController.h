//
//  LevelUpSuccessViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/18.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LevelUpSuccessType) {
    LevelUpSuccessTypeAlreadyVIP,
    LevelUpSuccessTypeVIP,
    LevelUpSuccessTypeServer,
    LevelUpSuccessTypeAreaServer,
};
@interface LevelUpSuccessViewController : SDBaseViewController

+ (void)showSuccessWithController:(UIViewController *)superController
                             type:(LevelUpSuccessType)type;
@end

NS_ASSUME_NONNULL_END
