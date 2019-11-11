//
//  VipPersonViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VipPersonViewModel : BaseRefreshViewModel
/** 选填项) 排序：消费时间 1 升序；2 降序 */
@property (nonatomic, strong, nullable) NSString *orderByLastPayTime;

/** 选填项) 排序：消费次数 1 升序；2 降序 */
@property (nonatomic, strong, nullable) NSString *orderByPayTimes;

/** 选填项) 排序：支付金额 1 升序；2 降序 */
@property (nonatomic, strong, nullable) NSString *orderByPayTotal;

/** 选填项) 排序：注册时间 1 升序；2 降序 */
@property (nonatomic, strong, nullable) NSString *orderByRegisterTime;

/**
 删除vip
 */
+ (void)deleteVipWithVipID:(NSString *)manId block:(SimpleBoolBlock)block;
@end

NS_ASSUME_NONNULL_END
