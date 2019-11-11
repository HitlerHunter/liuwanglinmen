//
//  SYHomeTableViewCell.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class SYHomeListModel;
@interface SYHomeTableViewCell : LZBaseTableViewCell

@property (nonatomic, strong) SYHomeListModel *model;
@end

NS_ASSUME_NONNULL_END
