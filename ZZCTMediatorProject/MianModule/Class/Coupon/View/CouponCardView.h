//
//  CouponCardView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CouponModel;
@interface CouponLeftCard : UIView

@end

@interface CouponRightCard : UIView

@end

@interface CouponCardView : UIView

@property (nonatomic, strong) CouponModel *model;
@end



NS_ASSUME_NONNULL_END
