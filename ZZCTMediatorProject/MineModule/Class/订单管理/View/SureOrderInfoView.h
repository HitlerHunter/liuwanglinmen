//
//  SureOrderInfoView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class GoodsCountSelectView,GoodsModel;
@interface SureOrderInfoView : SDBaseView
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) GoodsCountSelectView *countView;
@property (nonatomic, strong) GoodsModel *model;

@end

NS_ASSUME_NONNULL_END
