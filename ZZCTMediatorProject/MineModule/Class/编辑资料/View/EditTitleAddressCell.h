//
//  EditTitleAddressCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTitleAddressCell : SDBaseView

@property (nonatomic, strong) UILabel *title_label;
@property (nonatomic, strong) UILabel *text_label;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UIImageView *leftIcon;

@property (nonatomic, strong) void (^tapBlock)(void);

@end

NS_ASSUME_NONNULL_END
