//
//  MarketBoardCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MarketBoardCellModel;

@interface MarketBoardCell : SDBaseView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_info;

@property (nonatomic, strong) UILabel *label_status;
@property (nonatomic, strong) UIImageView *imageView_statu;

@property (nonatomic, strong) MarketBoardCellModel *model;
@end

NS_ASSUME_NONNULL_END
