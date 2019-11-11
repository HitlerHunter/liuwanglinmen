//
//  RewardRecordCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardRecordCell.h"
#import "RewardRecordModel.h"

@interface RewardRecordCell ()

@property (nonatomic, strong) UILabel *value1;
@property (nonatomic, strong) UILabel *value2;
@property (nonatomic, strong) UILabel *value3;

@end

@implementation RewardRecordCell

- (void)initUI{
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"悬赏费率" textColor:rgb(53,53,53)];
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(56);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"申请时间" textColor:rgb(152,152,152)];
    [self.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1);
        make.top.mas_equalTo(label1.mas_bottom).offset(12);
        make.height.mas_equalTo(label1);
        make.width.mas_equalTo(label1);
    }];
    
    UILabel *label3 = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"申请状态" textColor:rgb(152,152,152)];
    [self.contentView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1);
        make.top.mas_equalTo(label2.mas_bottom).offset(12);
        make.height.mas_equalTo(label1);
        make.width.mas_equalTo(label1);
    }];
    

    UILabel *value1 = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"45%" textColor:rgb(255,81,0)];
    [self.contentView addSubview:value1];
    [value1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(15);
        make.centerY.mas_equalTo(label1);
        make.height.mas_equalTo(label1);
        make.right.mas_equalTo(-30);
    }];
    
    UILabel *value2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"2019-08-15  12:20:15" textColor:rgb(152,152,152)];
    [self.contentView addSubview:value2];
    [value2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(value1);
        make.centerY.mas_equalTo(label2);
        make.height.mas_equalTo(value1);
        make.right.mas_equalTo(value1);
    }];
    
    UILabel *value3 = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"审核中" textColor:rgb(152,152,152)];
    [self.contentView addSubview:value3];
    [value3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(value1);
        make.centerY.mas_equalTo(label3);
        make.height.mas_equalTo(value1);
        make.right.mas_equalTo(value1);
    }];
    
    _value1 = value1;
    _value2 = value2;
    _value3 = value3;
    
    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"more_gray")];
    [self.contentView addSubview:moreIcon];
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setModel:(RewardRecordModel *)model{
    _model = model;
    
    _value1.text = [NSString stringWithFormat:@"%ld%%",_model.shareComp13.integerValue/100];
    _value2.text = model.createTime;
    _value3.text = getStatusTitleWithStatus(model.status_lz);
}

@end
