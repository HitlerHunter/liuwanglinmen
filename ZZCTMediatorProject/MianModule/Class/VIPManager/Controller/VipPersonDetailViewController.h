//
//  VipPersonDetailViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class VipPersonModel;
@interface VipPersonDetailViewController : SDBaseViewController

- (instancetype)initWithModel:(VipPersonModel *)model;

@end

NS_ASSUME_NONNULL_END
