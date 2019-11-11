//
//  CouponListViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponListViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *couponStatus;
@property (nonatomic, strong) NSString *couponType;

@end

NS_ASSUME_NONNULL_END
