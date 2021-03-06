//
//  AMBankBranchViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMBankBranchViewController : SDBaseViewController

@property (nonatomic, strong) void (^block)(NSString *bankName);

- (instancetype)initWithBankName:(NSString *)bankName;
@end

NS_ASSUME_NONNULL_END
