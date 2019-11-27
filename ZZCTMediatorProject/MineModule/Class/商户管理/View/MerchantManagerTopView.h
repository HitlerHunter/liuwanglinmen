//
//  MerchantManagerTopView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"
#import "MerchantManagerCardView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MerchantManagerTopView : SDBaseView

@property (nonatomic, strong) MerchantManagerCardView *cardView;
@property (nonatomic, strong) UILabel *lab_number;
@end

NS_ASSUME_NONNULL_END
