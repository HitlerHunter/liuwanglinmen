//
//  RewardRecordCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class RewardRecordModel;
@interface RewardRecordCell : LZBaseTableViewCell

@property (nonatomic, strong) RewardRecordModel *model;
@end

NS_ASSUME_NONNULL_END
