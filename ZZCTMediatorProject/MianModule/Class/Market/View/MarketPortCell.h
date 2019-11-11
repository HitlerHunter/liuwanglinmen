//
//  MarketPortCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketPortCell : SDBaseView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_info;
@property (nonatomic, strong) UILabel *label_subInfo;
@property (nonatomic, strong) UIImageView *moreIcon;

@property (nonatomic, copy) void (^clickBlock)(NSString *title);
@end

NS_ASSUME_NONNULL_END
