//
//  MarketBoardView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketBoardCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarketBoardView : SDBaseView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_status;
@property (nonatomic, strong) UIImageView *imageView_statu;
@property (nonatomic, strong) UIButton *createBoardBtn;

@property (nonatomic, strong) NSArray <MarketBoardCellModel *> *boardArray;


@end

NS_ASSUME_NONNULL_END
