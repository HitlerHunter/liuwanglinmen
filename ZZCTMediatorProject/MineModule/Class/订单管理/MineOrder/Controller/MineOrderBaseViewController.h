//
//  MineOrderBaseViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/18.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"
#import "MineOrderViewModel.h"
#import "MineOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineOrderBaseViewController : SDBaseViewController

@property (nonatomic, strong) MineOrderViewModel *viewModel;
- (instancetype)initWithStatus:(NSString *)status;
@end

NS_ASSUME_NONNULL_END
