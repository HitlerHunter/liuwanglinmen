//
//  CouponVipSectionHeaderView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CouponVipSectionModel;
@interface CouponVipSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) CouponVipSectionModel *model;
@property (nonatomic, strong) void (^didChangeChoiceBlock)(CouponVipSectionModel *sectionModel);
@end

NS_ASSUME_NONNULL_END
