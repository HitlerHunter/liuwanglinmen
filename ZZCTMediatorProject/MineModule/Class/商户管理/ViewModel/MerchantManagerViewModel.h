//
//  MerchantManagerViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MerchantManagerViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *acStatus;
@property (nonatomic, strong) NSString *merchantNum;
@property (nonatomic, strong) NSString *addMerchantNum;
@property (nonatomic, strong) NSString *reStatus;
@property (nonatomic, strong) NSString *unStatus;

@property (nonatomic, strong) NSString *total;

- (void)getTodayNewdataInfo;

+ (void)getMerchantInfoWithUserNo:(NSString *)userNo
                            block:(void (^)(LZUserMerchant *merchant))block;
@end

NS_ASSUME_NONNULL_END
