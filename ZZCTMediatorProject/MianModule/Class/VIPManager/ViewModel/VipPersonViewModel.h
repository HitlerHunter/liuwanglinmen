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
/** last_txn_time 、consumer_times、consumer_amt */
@property (nonatomic, strong, nullable) NSString *isDesc;

/** 选填项) 排序：消费次数 1 升序；2 降序 */
@property (nonatomic, strong, nullable) NSString *isAsc;


/**
 删除vip
 */
+ (void)deleteVipWithVipID:(NSString *)manId block:(SimpleBoolBlock)block;
+ (void)getVipDetailWithVipID:(NSString *)manId
                        block:(SimpleObjBlock)block;
@end

NS_ASSUME_NONNULL_END
