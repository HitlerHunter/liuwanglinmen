//
//  IntegralRecordViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordViewModel : BaseRefreshViewModel

/** all、income、withdraw，refund */
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *yearMonth;

@end

NS_ASSUME_NONNULL_END
