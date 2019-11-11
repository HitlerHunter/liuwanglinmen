//
//  VipPersonCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class VipPersonModel;
@interface VipPersonCell : LZBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_phone;

@property (nonatomic, strong) UILabel *label_money1;
@property (nonatomic, strong) UILabel *label_money2;

@property (nonatomic, strong) VipPersonModel *model;
@end

NS_ASSUME_NONNULL_END
