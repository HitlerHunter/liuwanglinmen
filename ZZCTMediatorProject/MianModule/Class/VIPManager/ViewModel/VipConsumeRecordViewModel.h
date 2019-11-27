//
//  VipConsumeRecordViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//
#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VipConsumeRecordViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *sumOrderAmt;
@property (nonatomic, strong) NSString *sumCount;

@end

NS_ASSUME_NONNULL_END
