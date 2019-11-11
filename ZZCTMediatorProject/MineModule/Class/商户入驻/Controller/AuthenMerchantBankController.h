//
//  AuthenMerchantBankController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/1.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthenMerchantBankController : SDBaseViewController

@property (nonatomic, strong) void (^block)(NSString *bankName);
@end

NS_ASSUME_NONNULL_END
