//
//  NoticeTableViewCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class NoticeModel;
@interface NoticeTableViewCell : LZBaseTableViewCell

@property (nonatomic, strong) NoticeModel *model;
@end

NS_ASSUME_NONNULL_END
