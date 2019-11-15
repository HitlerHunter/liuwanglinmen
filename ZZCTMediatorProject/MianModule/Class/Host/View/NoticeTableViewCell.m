//
//  NoticeTableViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import "NoticeModel.h"

extern NSString *getNoticeLogoWithType(NSString *type);

@interface NoticeTableViewCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UIImageView *logo;
@end

@implementation NoticeTableViewCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *avatar = [UIImageView new];
    [self.contentView addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UILabel *titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"悬赏任务发布成功" textColor:rgb(53,53,53)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(avatar.mas_centerY).offset(0);
        make.left.mas_equalTo(avatar.mas_right).offset(15);
        make.right.mas_equalTo(-15);
    }];
    
    UILabel *dateLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"2019-09-30  09:30" textColor:rgb(152,152,152)];
    [self.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(avatar.mas_centerY).offset(4);
        make.left.mas_equalTo(titleLabel);
        make.right.mas_equalTo(titleLabel);
    }];
    
    _titleLab = titleLabel;
    _dateLab = dateLabel;
    _logo = avatar;
    
    [self addBottomLine];
}

- (void)setModel:(NoticeModel *)model{
    _model = model;
    
    _titleLab.text = model.content;
    _dateLab.text = model.createdTime;
    _logo.image = UIImageName(getNoticeLogoWithType(model.noticeType));
    
}


@end

NSString *getNoticeLogoWithType(NSString *type){
    if (type.integerValue == 0) {
        return @"notice_sys";
    }else if (type.integerValue == 1) {
        return @"notice_xs";
    }else if (type.integerValue == 3) {
        return @"notice_jf";
    }else if (type.integerValue == 4) {
        return @"notice_coupon";
    }
    return @"";
}
