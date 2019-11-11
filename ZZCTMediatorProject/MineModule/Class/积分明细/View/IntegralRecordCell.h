//
//  IntegralRecordCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/18.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordCell : LZBaseTableViewCell
@property (nonatomic, strong) UILabel *label_status;
@property (nonatomic, strong) UILabel *label_info;
@property (nonatomic, strong) UILabel *label_money;
@property (nonatomic, strong) UILabel *label_type;

@property (nonatomic, strong) UIImageView *iconView;
@end

NS_ASSUME_NONNULL_END

