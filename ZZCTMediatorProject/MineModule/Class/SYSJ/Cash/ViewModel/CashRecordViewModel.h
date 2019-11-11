//
//  CashRecordViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/26.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashRecordViewModel : BaseRefreshViewModel

/**
 category (string, optional): 0（或者不传）：全部、40：提现成功、50：提现失败、60：提现中 ,
 */
@property (nonatomic, strong, null_resettable) NSString *category;
@end

NS_ASSUME_NONNULL_END
