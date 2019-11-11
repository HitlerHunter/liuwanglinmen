//
//  DataCollectionAllView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataCollectionAllView : SDBaseView

@property (nonatomic, strong) UILabel *label_date;
@property (nonatomic, strong) UILabel *label_orderMoney;
@property (nonatomic, strong) UILabel *label_orderCount;
@property (nonatomic, strong) UILabel *label_refundMoney;
@property (nonatomic, strong) UILabel *label_refundCount;
@property (nonatomic, strong) UILabel *label_axtMoney;

@property (nonatomic, strong) UILabel *label_kjsMoney;


/**可结算金额*/
@property (nonatomic, strong) NSString *canEndMoney;
@end

NS_ASSUME_NONNULL_END
