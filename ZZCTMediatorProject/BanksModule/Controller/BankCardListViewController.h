//
//  BankCardListViewController.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/19.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DebitCardModel;
@interface BankCardListViewController : SDBaseViewController

@property (nonatomic, strong) void (^didSelectBlock)(NSString *cardId, NSString *bankName);
@property (nonatomic, strong) void (^didSelectBlock2)(DebitCardModel *card);

- (instancetype)initWithIsSelectVC:(BOOL)isSelectVC;
@end

NS_ASSUME_NONNULL_END
