//
//  MarketBoardCreateViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MarketBoardCellModel;
@interface MarketBoardCreateViewController : SDBaseViewController

- (instancetype)initWithBoardModel:(MarketBoardCellModel *)model;
@end

NS_ASSUME_NONNULL_END
