//
//  MineOrderDetailViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/25.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class MineOrderModel;
@interface MineOrderDetailViewController : SDBaseViewController

- (instancetype)initWithOrderId:(NSString *)OrderId;
@end

NS_ASSUME_NONNULL_END
