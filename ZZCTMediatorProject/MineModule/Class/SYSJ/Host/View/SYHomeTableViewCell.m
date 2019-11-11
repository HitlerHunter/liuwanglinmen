//
//  SYHomeTableViewCell.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SYHomeTableViewCell.h"
#import "SYHomeListModel.h"

@interface SYHomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *label_1;
@property (weak, nonatomic) IBOutlet UILabel *label_2;
@property (weak, nonatomic) IBOutlet UILabel *label_3;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation SYHomeTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self addTopLine];
    self.avatar.lz_setView.lz_cornerRadius(self.avatar.height*0.5);
}

- (void)setModel:(SYHomeListModel *)model{
    _model = model;
    
    self.avatar.image = [AppCenter defaultAppAvatar];
    if (!IsNull(model.txnUserHeader)) {
        [self.avatar sd_setImageWithURL:TLURL(model.txnUserHeader) placeholderImage:[AppCenter defaultAppAvatar]];
    }
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@",model.txnUserName];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@",model.txnUserMobile.phoneTakeSecure];
    
    self.label_1.text = [NSString stringWithFormat:@"交易金额：%@",[NSString formatMoneyCentToYuanString:model.flowAmt]];
    self.label_2.text = [NSString stringWithFormat:@"交易类型：%@",model.showType];
    self.label_3.text = [NSString stringWithFormat:@"交易时间：%@",model.txnDate];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",[NSString formatMoneyCentToYuanString:model.rebAmt]];
    self.typeLabel.text = model.showType;
    
    NSString *levelStr = getRoleNameWithLZUserTypeAndLevel(LZUserTypeMember, model.txnUserLvl);
    self.userLevelLabel.text = levelStr;
    
    NSString *icon = getRoleIconWithLevel(model.txnUserLvl);
    _levelIconImageView.image = UIImageName(icon);
}

@end
