//
//  SYHomeHeader.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SDBaseView.h"
#import "SYHomeTypeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYHomeHeader : SDBaseView
@property (weak, nonatomic) IBOutlet UILabel *moneyAllLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *canCashMoneyLabel;

@property (nonatomic, strong) NSString *allMoney;

@property (nonatomic, strong) void (^toCashBlock)(void);

@property (nonatomic, weak) id <SYHomeTypeViewDelegate> delegate;

- (void)setTitleArray:(NSArray *)titleArray;
@end

NS_ASSUME_NONNULL_END
