//
//  OrderRefundViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/27.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BookOrderDetailModel;
@interface OrderRefundViewController : SDBaseViewController

- (instancetype)initWithModel:(BookOrderDetailModel *)model;
@end

NS_ASSUME_NONNULL_END
