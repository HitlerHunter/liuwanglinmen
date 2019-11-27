//
//  VipPersonModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipPersonModel : NSObject

@property (nonatomic, strong) NSString *receiptUsrNo;
@property (nonatomic, strong) NSString *txnUsrNo;
@property (nonatomic, strong) NSString *txnUserHeader;
@property (nonatomic, strong) NSString *txnUserName;
@property (nonatomic, strong) NSString *txnUserMobile;
@property (nonatomic, strong) NSString *lastTxnTime;
@property (nonatomic, strong) NSString *consumerTimes;
@property (nonatomic, strong) NSString *consumerAmt;
@property (nonatomic, strong) NSString *explains;

@end

NS_ASSUME_NONNULL_END
