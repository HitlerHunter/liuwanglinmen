//
//  MessageSendRecordCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageSendRecordCell.h"
#import "MessageSendRecordModel.h"
#import "CouponSendRecordModel.h"
#import "CouponModel.h"

@implementation MessageSendRecordCell

- (void)initUI{
    
    self.backgroundColor = LZBackgroundColor;
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
    bgView.lz_setView.lz_cornerRadius(6);
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"" textColor:rgb(53,53,53)];
    label_title.numberOfLines = 2;
    
    UILabel *label_status = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"" textColor:rgb(152,152,152)];
    UILabel *label_count = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    UILabel *label_date = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    UILabel *label_type = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
  
    UIView *line = [UIView new];
    line.backgroundColor = rgb(242,242,242);
    
    _label_title = label_title;
    _label_status = label_status;
    _label_count = label_count;
    _label_date = label_date;
    _label_type = label_type;
    
    [bgView addSubview:label_title];
    [bgView addSubview:label_status];
    [bgView addSubview:label_count];
    [bgView addSubview:label_date];
    [bgView addSubview:label_type];
    [bgView addSubview:line];
    
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.mas_lessThanOrEqualTo(-65);
    }];
    
    [label_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_title.mas_right);
        make.centerY.mas_equalTo(label_title);
    }];
    
    [label_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_title);
        make.top.mas_equalTo(label_title.mas_bottom).offset(10);
    }];
    
    [label_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_count);
        make.right.mas_equalTo(-15);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(label_count.mas_bottom).offset(10);
    }];
    
    [label_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(8);
        make.bottom.mas_equalTo(-8);
        make.left.mas_equalTo(label_count);
    }];
    
    bgView.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
}

- (void)setModel:(MessageSendRecordModel *)model{
    _model = model;
    
    _label_title.text = model.sendHead;
    _label_status.text = [NSString stringWithFormat:@" (%@)",getMessageSendTaskStatusTitleWithStatus(model.taskStatus)];
    
    _label_count.text = IsNull(model.sendTimes)?@"0":model.sendTimes;
    _label_date.text = IsNull(model.createTime)?@"":model.createTime;
    _label_type.text = getMessageSendTaskSMSTypeTitleWithSMSType(model.smsType);
 
    @weakify(self);
    [[RACObserve(model, taskStatus) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.label_status.text = [NSString stringWithFormat:@" (%@)",getMessageSendTaskStatusTitleWithStatus(model.taskStatus)];
    }];
}

- (void)setCouponSendRecordModel:(CouponSendRecordModel *)couponSendRecordModel{
    _couponSendRecordModel = couponSendRecordModel;
 
    _label_title.text = @"发送会员";
    
    NSString *str = IsNull(couponSendRecordModel.distributionNum)?@"0":couponSendRecordModel.distributionNum;
    _label_count.text = [NSString stringWithFormat:@"%@张",str];
    _label_date.text = IsNull(couponSendRecordModel.createTime)?@"":couponSendRecordModel.createTime;
    _label_type.text = couponSendRecordModel.couponName;
}

@end
