//
//  RewardViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class RewardRecordModel;
@interface RewardViewModel : NSObject
/**悬赏模块*/
+ (void)pushToRewardMoudleWithNav:(UINavigationController *)nav;
/**编辑悬赏界面*/
+ (void)pushToRewardViewControllerWithNav:(UINavigationController *)nav;

+ (void)pushToRewardRecordViewControllerWithNav:(UINavigationController *)nav;
/**添加商户费率修改记录*/
+ (void)submitChangeRewardWithValue:(NSString *)value
                             image1:(UIImage *)image1
                             image2:(UIImage *)image2
                              block:(SimpleBoolBlock)block;
+ (void)getLastRewardWithBlock:(void (^)(RewardRecordModel *model))block;
@end

NS_ASSUME_NONNULL_END
