//
//  LZUserWallet.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZUserWallet : NSObject

@property (nonatomic, strong) NSString *freezeBalance;
@property (nonatomic, strong) NSString *totalIncome;
@property (nonatomic, strong) NSString *totalSpend;
@property (nonatomic, strong) NSString *balance;

@end

NS_ASSUME_NONNULL_END
