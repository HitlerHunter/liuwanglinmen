//
//  MineKefuCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineKefuCell : SDBaseView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_info;
@property (nonatomic, strong) UILabel *label_subInfo;

@property (nonatomic, copy) void (^clickBlock)(NSString *title);
@end

NS_ASSUME_NONNULL_END
