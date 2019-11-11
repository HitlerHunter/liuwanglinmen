//
//  CouponChoiceCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponChoiceCell : SDBaseView

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UILabel *text_label;
@property (nonatomic, strong) UIImageView *rightIcon;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
