//
//  MerchantManagerCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class MerchantManagerModel;
@interface MerchantManagerCell : LZBaseTableViewCell

@property (nonatomic, strong) MerchantManagerModel *model;
@end

NS_ASSUME_NONNULL_END
