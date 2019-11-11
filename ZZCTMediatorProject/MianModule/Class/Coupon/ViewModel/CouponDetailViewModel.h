//
//  CouponDetailViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponDetailViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *couponId;
/**1、顺序 2、倒叙*/
@property (nonatomic, strong) NSString *orderBy;
/**1、创建时间 2、核销时间*/
@property (nonatomic, strong) NSString *sortBy;

/**领取数量*/
@property (nonatomic, assign) NSInteger distributedSum;
/**核销数量*/
@property (nonatomic, assign) NSInteger verifySum;


- (void)getDetailTopData;
@end

NS_ASSUME_NONNULL_END
