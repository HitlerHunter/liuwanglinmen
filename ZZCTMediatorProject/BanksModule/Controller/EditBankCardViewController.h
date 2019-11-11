//
//  EditBankCardViewController.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/24.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DebitCardModel;
@interface EditBankCardViewController : SDBaseViewController

- (instancetype)initWithModel:(DebitCardModel *)model;
@end

NS_ASSUME_NONNULL_END
