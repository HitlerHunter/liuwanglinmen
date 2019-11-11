//
//  CouponDetailTableViewCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class CouponVipModel;
@interface CouponDetailTableViewCell : LZBaseTableViewCell
@property (nonatomic, strong) CouponVipModel *model;
@end

NS_ASSUME_NONNULL_END
