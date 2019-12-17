//
//  NoMoreOrderView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoMoreOrderView : SDBaseView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) void (^clickBlock)(void);
@end

NS_ASSUME_NONNULL_END
