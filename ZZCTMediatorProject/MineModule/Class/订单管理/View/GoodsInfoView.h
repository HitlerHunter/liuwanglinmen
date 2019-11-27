//
//  GoodsInfoView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsInfoView : SDBaseView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, assign) NSInteger count;
@end

NS_ASSUME_NONNULL_END
