//
//  MarketInvestRecordCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketInvestRecordCell : LZBaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_info;
@property (nonatomic, strong) UILabel *label_money;

- (void)isHiddenTopLine:(BOOL)isHidden;
- (void)originalLine;
@end

NS_ASSUME_NONNULL_END
