//
//  MianSectionHeader.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/12.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MianSectionHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *moreIcon;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) void (^clickBlock)(void);
@end

NS_ASSUME_NONNULL_END
