//
//  MianSectionHeader.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/12.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MianSectionHeader.h"

@implementation MianSectionHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        self.contentView.backgroundColor = LZWhiteColor;
    }
    return self;
}

- (void)initUI{
    
    _titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"信用卡专区" textColor:rgb(18,18,18)];
    
    _rightLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"查看更多" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentRight];
    _moreIcon = [UIImageView viewWithImage:UIImageName(@"gengduo")];
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_moreIcon];
    [self.contentView addSubview:_rightLabel];
    [self.contentView addSubview:_moreBtn];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(15);
    }];
    
    [_moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView).offset(-17);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.moreIcon);
        make.right.mas_equalTo(self.moreIcon.mas_left).offset(-4);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.rightLabel.mas_left);
    }];
    
    @weakify(self);
    [_moreBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock();
        }
    }];
}
@end
