//
//  MineMessageDetailViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class HomeMessageModel;
@interface MineMessageDetailViewController : SDBaseViewController

@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (nonatomic, strong) HomeMessageModel *model;
@property (nonatomic, strong) void (^clickBlock)(void);

- (instancetype)initWithModel:(HomeMessageModel *)model;

@end

NS_ASSUME_NONNULL_END
