//
//  CreditCardListViewController.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/24.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BankCardModel;
@interface CreditCardListViewController : SDBaseViewController

@property (nonatomic, strong) void (^didSelectBlock)(NSString *cardId, NSString *bankName);
@property (nonatomic, strong) void (^didSelectBlock2)(BankCardModel *card);

- (instancetype)initWithIsSelectVC:(BOOL)isSelectVC;
@end

NS_ASSUME_NONNULL_END
