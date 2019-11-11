//
//  CashTitleInfoCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/15.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashTitleInfoCell : SDBaseView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

+ (CashTitleInfoCell *)cellWithTitle:(NSString *)title
                               vaule:(NSString *)vaule;
@end

NS_ASSUME_NONNULL_END
