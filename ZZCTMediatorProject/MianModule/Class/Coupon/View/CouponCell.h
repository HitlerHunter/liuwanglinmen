//
//  CouponCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CouponModel;
@interface CouponCell : UITableViewCell

@property (nonatomic, strong) CouponModel *model;
@property (nonatomic, assign) BOOL canSelected;
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
