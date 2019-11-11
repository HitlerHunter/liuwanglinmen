//
//  EditWorkTimeCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditWorkTimeCell.h"
#import "HooDatePicker.h"

@interface EditWorkTimeCell ()<HooDatePickerDelegate>
@property (nonatomic, assign) BOOL isStart;
@property (nonatomic, strong) UILabel *dateStartLabel;
@property (nonatomic, strong) UILabel *dateEndLabel;

@property (nonatomic, strong) HooDatePicker *YMDPicker;

@end

@implementation EditWorkTimeCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:14 textColor:rgb(101,101,101)];
    [self addSubview:title_label];
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    
    UILabel *dateEndLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"结束时间" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    [self addSubview:dateEndLabel];
    [dateEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(70);
        make.centerY.mas_equalTo(self);
    }];
    
    UILabel *label = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"至" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(dateEndLabel.mas_left).offset(-10);
        make.width.mas_greaterThanOrEqualTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
    UILabel *dateStartLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"开始时间" textColor:rgb(152,152,152)];
    [self addSubview:dateStartLabel];
    [dateStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(label.mas_left).offset(-10);
        make.width.mas_equalTo(70);
        make.centerY.mas_equalTo(self);
    }];
    
    _title_label = title_label;
    _dateStartLabel = dateStartLabel;
    _dateEndLabel = dateEndLabel;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startChoice)];
    dateStartLabel.userInteractionEnabled = YES;
    [dateStartLabel addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endChoice)];
    dateEndLabel.userInteractionEnabled = YES;
    [dateEndLabel addGestureRecognizer:tap2];
    

}

- (void)setTitle:(NSString *)title{
    _title_label.text = title;
}

- (void)startChoice{
    self.isStart = YES;
    [self.YMDPicker show];
}

- (void)endChoice{
    self.isStart  = NO;
    [self.YMDPicker show];
}

#pragma mark - dateDelegate
- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    NSString *dateStr = [date formatHM];
    
    if (self.isStart) {
        _dateStartLabel.text = dateStr;
        self.start = dateStr;
    }else {
        _dateEndLabel.text = dateStr;
        self.end = dateStr;
    }
    
}

- (void)setStart:(NSString *)start End:(NSString *)end{
    _start = start;
    if (IsNull(start)) {
        start = @"开始时间";
    }
    _dateStartLabel.text = start;
    
    _end = end;
    if (IsNull(end)) {
        end = @"结束时间";
    }
    _dateEndLabel.text = end;
}

- (HooDatePicker *)YMDPicker{
    if (!_YMDPicker) {
        _YMDPicker = [[HooDatePicker alloc] initWithSuperView:KeyWindow];
        _YMDPicker.delegate = self;
        _YMDPicker.datePickerMode = HooDatePickerModeTime;
        _YMDPicker.timeZone = [NSTimeZone localTimeZone];
//        _YMDPicker.minimumDate = [NSDate date];
    }
    return _YMDPicker;
}
@end
