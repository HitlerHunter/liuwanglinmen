//
//  IntegralRecordSectionHeader.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/9.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "IntegralRecordSectionHeader.h"
#import "DataTypeChoiceButton.h"

@interface IntegralRecordSectionHeader ()

@property (nonatomic, strong) DataTypeChoiceButton *button;
@end

@implementation IntegralRecordSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _button = (DataTypeChoiceButton *)[DataTypeChoiceButton buttonWithFontSize:13 text:@"本月" textColor:rgb(53,53,53)];
        
        [_button setImage:UIImageName(@"xiala") forState:UIControlStateNormal];
        _button.backgroundColor = LZWhiteColor;
        [self.contentView addSubview:_button];
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(80, 24));
        }];
        
        _button.lz_setView.lz_cornerRadius(12);
        
        [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    CGFloat textW = [title tt_sizeWithFont:Font_PingFang_SC_Medium(13)].width;
    CGFloat btnW = 60;
    if (textW > 24) {
        btnW = textW + 36;
    }
    
    [_button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, 24));
    }];
    
    [_button setTitle:title forState:UIControlStateNormal];
}

- (void)btnClick{
    
    if (_selectDateBlock) {
        _selectDateBlock(_title);
    }
}

@end
