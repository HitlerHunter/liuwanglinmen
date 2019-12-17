//
//  MineOrderTableViewCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/18.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class MineOrderModel;
@interface MineOrderTableViewCell : LZBaseTableViewCell

@property (nonatomic, strong) MineOrderModel *model;
@end

NS_ASSUME_NONNULL_END
