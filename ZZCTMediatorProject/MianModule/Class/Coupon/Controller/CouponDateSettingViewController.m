//
//  CouponDateSettingViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponDateSettingViewController.h"
#import "HooDatePicker.h"

@implementation CouponDate

@end

@interface CouponDateSettingViewController ()<HooDatePickerDelegate>

@property (nonatomic, strong) UIButton *selectBtn1;
@property (nonatomic, strong) UIButton *selectBtn2;

@property (nonatomic, strong) UILabel *dateStartLabel;
@property (nonatomic, strong) UILabel *dateEndLabel;

@property (nonatomic, strong) HooDatePicker *YMDPicker;

@end

@implementation CouponDateSettingViewController

- (CouponDate *)model{
    if (!_model) {
        _model = [CouponDate new];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增优惠券";
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"确定" font:nil color:nil block:^{
        @strongify(self);
        
        if (self.didChangeBlock) {
            
            if (self.model.isCustomDate) {
                if (self.model.startDate && self.model.endDate) {
                    self.didChangeBlock(self.model);
                }
            }else{
                self.didChangeBlock(self.model);
            }
            [self lz_popController];
        }
    }];
    
    UILabel *lab = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"有效期" textColor:rgb(101,101,101)];
    [self.view addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.base_navigationbarHeight+15);
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = LZWhiteColor;
    [self.view addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(lab.mas_bottom).offset(10);
    }];
    
    _selectBtn1 = [self btn];
    [view1 addSubview:_selectBtn1];
    [_selectBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(view1);
        make.width.mas_equalTo(44);
    }];
    
    [_selectBtn1 addTouchAction:^(UIButton *sender) {
        sender.selected = YES;
        @strongify(self);
        self.selectBtn2.selected = NO;
        self.model.isCustomDate = YES;
    }];
    
    UILabel *dateStartLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"开始时间" textColor:rgb(152,152,152)];
    [view1 addSubview:dateStartLabel];
    [dateStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn1.mas_right);
        make.width.mas_greaterThanOrEqualTo(60);
        make.centerY.mas_equalTo(view1);
    }];
    
    UILabel *label = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"至" textColor:rgb(53,53,53)];
    [view1 addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dateStartLabel.mas_right).offset(10);
        make.width.mas_greaterThanOrEqualTo(15);
        make.centerY.mas_equalTo(view1);
    }];
    
    UILabel *dateEndLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"结束时间" textColor:rgb(152,152,152)];
    [view1 addSubview:dateEndLabel];
    [dateEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(10);
        make.width.mas_greaterThanOrEqualTo(60);
        make.centerY.mas_equalTo(view1);
    }];
    
    _dateStartLabel = dateStartLabel;
    _dateEndLabel = dateEndLabel;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startChoice)];
    dateStartLabel.userInteractionEnabled = YES;
    [dateStartLabel addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endChoice)];
    dateEndLabel.userInteractionEnabled = YES;
    [dateEndLabel addGestureRecognizer:tap2];
    
    
    //cell2
    UIView *view2 = [UIView new];
    view2.backgroundColor = LZWhiteColor;
    [self.view addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(view1.mas_bottom).offset(15);
    }];
    
    _selectBtn2 = [self btn];
    [view2 addSubview:_selectBtn2];
    [_selectBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(view2);
        make.width.mas_equalTo(44);
    }];
    _selectBtn2.selected = YES;
    [_selectBtn2 addTouchAction:^(UIButton *sender) {
        sender.selected = YES;
        @strongify(self);
        self.selectBtn1.selected = NO;
        self.model.isCustomDate = NO;
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"永久有效" textColor:rgb(53,53,53)];
    [view2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn2.mas_right);
        make.centerY.mas_equalTo(view2);
    }];
    
}

- (UIButton *)btn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:UIImageName(@"coupon_unSelected") forState:UIControlStateNormal];
    [button setImage:UIImageName(@"coupon_selected") forState:UIControlStateSelected];
    return button;
}

- (void)startChoice{
    self.model.isStart = YES;
    [self.YMDPicker show];
}

- (void)endChoice{
    self.model.isStart  = NO;
    [self.YMDPicker show];
}

#pragma mark - dateDelegate
- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    NSString *dateStr = [date formatYMDWithSeparate:@"-"];
    dateStr = [dateStr substringToIndex:10];
    
    if (self.model.isStart) {
        self.model.startDate = date;
        self.model.startDateStr = dateStr;
        _dateStartLabel.text = dateStr;
    }else {
        self.model.endDate = date;
        self.model.endDateStr = dateStr;
        _dateEndLabel.text = dateStr;
    }
    
}

- (HooDatePicker *)YMDPicker{
    if (!_YMDPicker) {
        _YMDPicker = [[HooDatePicker alloc] initWithSuperView:KeyWindow];
        _YMDPicker.delegate = self;
        _YMDPicker.datePickerMode = HooDatePickerModeDate;
        _YMDPicker.timeZone = [NSTimeZone localTimeZone];
        _YMDPicker.minimumDate = [NSDate date];
    }
    return _YMDPicker;
}
@end
