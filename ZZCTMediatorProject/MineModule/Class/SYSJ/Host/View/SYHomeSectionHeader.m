//
//  SYHomeSectionHeader.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SYHomeSectionHeader.h"

@implementation SYHomeSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        self.contentView.backgroundColor = rgb(234,234,234);
    }
    return self;
}

- (void)initUI{
    
    
    _titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(101,101,101)];
    
    _rightLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(101,101,101) textAlignment:NSTextAlignmentRight];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_rightLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(17);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-13);
    }];
   
}

@end
