//
//  MineAddressViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class MineAddressModel;
@interface MineAddressViewController : SDBaseViewController

@property (nonatomic, strong) void (^didSelectBlock)(MineAddressModel *address);
@end

NS_ASSUME_NONNULL_END
