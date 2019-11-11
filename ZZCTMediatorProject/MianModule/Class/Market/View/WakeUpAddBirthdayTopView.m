//
//  WakeUpAddBirthdayTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "WakeUpAddBirthdayTopView.h"
#import "HooDatePicker.h"

@interface WakeUpAddBirthdayTopView ()<HooDatePickerDelegate>
@property (nonatomic, strong) HooDatePicker *YMDPicker;

@end

@implementation WakeUpAddBirthdayTopView

- (void)initUI{
    [self addTopLine];
    [self addBottomLine];
    
    self.backgroundColor = LZWhiteColor;
    
    UIView *topView = [UIView new];
    [self addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(self).multipliedBy(0.4);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = UIColorHex(0xF2ECE8);
    [topView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(topView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(topView.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
    
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTapClick)];
    [topView addGestureRecognizer:topTap];
    
    [self initTopViewWithView:topView];
    [self initBottomViewWithView:bottomView];
}

- (void)initTopViewWithView:(UIView *)topView{
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"每天" textColor:[UIColor grayColor]];
    UILabel *label_time = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"选择时间" textColor:rgb(53,53,53)];
    label_time.textAlignment = NSTextAlignmentRight;
    
    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"more_gray")];
    
    _label_time = label_time;
    
    [topView addSubview:label_title];
    [topView addSubview:label_time];
    [topView addSubview:moreIcon];
    
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(topView);
    }];
    
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(7, 15));
    }];
    
    [label_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.right.mas_equalTo(moreIcon.mas_left).offset(-5);
        make.left.mas_equalTo(label_title.mas_right);
        make.height.mas_equalTo(topView);
    }];
    
    
}

- (void)initBottomViewWithView:(UIView *)View{
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"向超过" textColor:[UIColor grayColor]];
    UILabel *label_info = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"天未消费的成员发送短信" textColor:[UIColor grayColor]];
    label_info.textAlignment = NSTextAlignmentRight;
    
    UITextField *textField = [UITextField new];
    textField.maxLength = 3;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.backgroundColor = rgb(242,242,242);
    textField.placeholder = @"请输入天数";
    textField.font = Font_PingFang_SC_Regular(14);
    
    [View addSubview:label_title];
    [View addSubview:textField];
    [View addSubview:label_info];
    
    _label_day = textField;
    
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(View);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(View);
    }];
    
    
    [label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(View);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(View);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(View);
        make.right.mas_equalTo(label_info.mas_left).offset(-5);
        make.left.mas_equalTo(label_title.mas_right).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_greaterThanOrEqualTo(74);
    }];
    textField.lz_setView.lz_border(1, rgb(204, 204, 204));
    
    _label_bottomLeft = label_title;
    _label_bottomRight = label_info;
    
    @weakify(self);
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.day = x;
    }];
}


- (void)topTapClick{
    [self.YMDPicker show];
}


#pragma mark - dateDelegate
- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    NSString *hm = [date formatHM];
    
    _label_time.text = hm;
    _time = hm;
}

- (void)setTime:(NSString *)time{
    _time = time;
    _label_time.text = time;
}

- (void)setDay:(NSString *)day{
    _day = day;
    _label_day.text = day;
}


- (HooDatePicker *)YMDPicker{
    if (!_YMDPicker) {
        _YMDPicker = [[HooDatePicker alloc] initDatePickerMode:HooDatePickerModeTime andAddToSuperView:KeyWindow];
        _YMDPicker.delegate = self;
        _YMDPicker.timeZone = [NSTimeZone localTimeZone];
    }
    return _YMDPicker;
}
@end
