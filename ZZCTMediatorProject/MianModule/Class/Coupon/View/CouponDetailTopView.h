//
//  CouponDetailTopView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponDetailTopView : SDBaseView

/**已领取*/
@property (nonatomic, assign) NSInteger hasReceivedNumber;
/**已核销*/
@property (nonatomic, assign) NSInteger hasUsedNumber;

@end

NS_ASSUME_NONNULL_END
