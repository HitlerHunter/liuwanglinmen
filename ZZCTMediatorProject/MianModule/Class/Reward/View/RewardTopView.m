//
//  RewardTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardTopView.h"
#import "RewardTopInfoView.h"

@interface RewardTopView ()
@property (nonatomic, strong) RewardTopInfoView *infoView;
@end

@implementation RewardTopView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *titleLab = [UILabel labelWithFontSize:15 textColor:UIColorHex(0x3A3A3A)];
    titleLab.text = @"悬赏费率设置";
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(23);
    }];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.maxLength = 2;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.textColor = rgb(204,204,204);
    tf.textAlignment = NSTextAlignmentRight;
    tf.backgroundColor = UIColorHex(0xF5F5F5);
    tf.font = Font_PingFang_SC_Medium(15);
    tf.textAlignment = NSTextAlignmentCenter;
    tf.lz_setView.lz_cornerRadius(2).lz_border(0.5, UIColorHex(0xE5E5E5));
    _textF = tf;
    [self addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.right.mas_equalTo(self).mas_offset(-15);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(23);
    }];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    lab.text = @"百分之";
    lab.font = Font_PingFang_SC_Regular(14);
    lab.textColor = rgb(101,101,101);
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(48);
        make.right.mas_equalTo(tf.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(23);
    }];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:UIImageName(@"reward_jieshi") forState:UIControlStateNormal];
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [btn addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self addBottomLine];
    [self setBottomLineX:15];
}

- (void)showInfo{
    
    
    if (!_infoView) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenInfoView)];
        [self.superview addGestureRecognizer:tap];
    }
    
    [_infoView removeFromSuperview];
    [self.superview addSubview:self.infoView];
    
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(68);
        make.top.mas_equalTo(self.mas_bottom).offset(-14);
        make.width.mas_equalTo(240);
        make.height.mas_greaterThanOrEqualTo(90);
    }];
    
}

- (void)hiddenInfoView{
    [_infoView removeFromSuperview];
}

- (RewardTopInfoView *)infoView{
    if (!_infoView) {
        _infoView = [RewardTopInfoView new];
    }
    return _infoView;
}
@end
