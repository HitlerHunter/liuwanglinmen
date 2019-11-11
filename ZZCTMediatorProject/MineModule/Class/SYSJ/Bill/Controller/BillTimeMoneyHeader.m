//
//  BillTimeMoneyHeader.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/28.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BillTimeMoneyHeader.h"

@interface BillTimeMoneyHeader ()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end

@implementation BillTimeMoneyHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LZWhiteColor;
        
        _dateLabel = [UILabel labelWithFontSize:16 textColor:LZNavBarTitleColor];
        [self addSubview:_dateLabel];
        
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(25);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(18);
            
        }];
        
        _moneyLabel = [UILabel labelWithFontSize:16 textColor:LZNavBarTitleColor textAlignment:NSTextAlignmentRight];
        [self addSubview:_moneyLabel];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-25);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(18);
            
        }];
        
    }
    return self;
}

- (void)setMoney:(NSString *)money{
    _money = money;
    
    _moneyLabel.text = [NSString stringWithFormat:@"¥%@",money];
}

- (void)setMonth:(NSString *)month{
    _month = month;
    
    _dateLabel.text = month;
}
@end
