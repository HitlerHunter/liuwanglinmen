//
//  CashRecordCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/26.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashRecordCell : LZBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

NS_ASSUME_NONNULL_END
