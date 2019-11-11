//
//  CouponInputTextCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponInputTextCell : SDBaseView

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *right_label;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *textPlaceholder;
@property (nonatomic, strong) NSString *rightText;
@end

NS_ASSUME_NONNULL_END
