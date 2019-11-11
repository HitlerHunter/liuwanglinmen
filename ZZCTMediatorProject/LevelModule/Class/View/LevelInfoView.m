//
//  LevelInfoView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelInfoView.h"

@implementation LevelInfoCellModel

+ (LevelInfoCellModel *)modelWithTitle:(NSString *)title
                                  text:(NSString *)text
                               tagInfo:(NSString *)tagInfo
                             imageName:(NSString *)imageName{
    
    LevelInfoCellModel *model = [LevelInfoCellModel new];
    model.title = title;
    model.text = text;
    model.tagInfo = tagInfo;
    model.imageName = imageName;
    return model;
}

@end

@implementation LevelInfoModel
/**
 * 1:交易 2:悬赏  3:套现  4:办卡  5:升级  6:购物  7:充值 8:退款  9:提现
 * @author free loop
 * @version 1.0
 * @date 2019-10-09 11:45
 */

+ (LevelInfoModel *)modelWithType:(LevelInfoType)type
                              dic:(NSDictionary *)dic{
    LevelInfoModel *model = [LevelInfoModel new];
    model.type = type;
    model.isBtnAble = YES;
    
    LevelInfoCellModel *cellModel1 = [LevelInfoCellModel modelWithTitle:dic[@"1"][@"title"] text:dic[@"1"][@"explains"] tagInfo:@"财富保障" imageName:@"level_shoukuan"];
    LevelInfoCellModel *cellModel2 = [LevelInfoCellModel modelWithTitle:dic[@"2"][@"title"] text:dic[@"2"][@"explains"] tagInfo:@"" imageName:@"level_xuanshang"];
    LevelInfoCellModel *cellModel3 = [LevelInfoCellModel modelWithTitle:dic[@"3"][@"title"] text:dic[@"3"][@"explains"] tagInfo:@"多办多得" imageName:@""];
    LevelInfoCellModel *cellModel4 = [LevelInfoCellModel modelWithTitle:dic[@"4"][@"title"] text:dic[@"4"][@"explains"] tagInfo:@"" imageName:@"level_gouwu"];
    LevelInfoCellModel *cellModel5 = [LevelInfoCellModel modelWithTitle:dic[@"5"][@"title"] text:dic[@"5"][@"explains"] tagInfo:@"" imageName:@"level_tuijian"];

    //限时活动
    if (type == LevelInfoTypeVIP) {
        model.title = @"五大权益";
        model.btnTitle = [NSString stringWithFormat:@"￥%@  立即升级",dic[@"upgradeAmount"]];
        model.cellModelArray = @[cellModel1,cellModel2,cellModel3,cellModel4,cellModel5];
        
        if (CurrentUser.userLvl >= LevelInfoTypeVIP) {
            model.btnTitle = @"已升级";
            model.isBtnAble = NO;
        }
        
    }else if (type == LevelInfoTypeServer) {
        
        cellModel5.tagInfo = @"";
        
        model.title = @"五大权益";
        model.btnTitle = [NSString stringWithFormat:@"￥%@ 立即升级",dic[@"upgradeAmount"]];
        model.cellModelArray = @[cellModel1,cellModel2,cellModel3,cellModel4,cellModel5];
        
        if (CurrentUser.userLvl >= LevelInfoTypeServer) {
            model.btnTitle = @"已升级";
            model.isBtnAble = NO;
        }
        
    }else if (type == LevelInfoTypeAreaServer) {
        model.title = @"独家收益";
        model.btnTitle = @"抢位申请";

        cellModel1.imageName = @"";
        cellModel1.tagInfo = @"";
        
        cellModel2.imageName = @"";
        cellModel4.imageName = @"";
        
        cellModel3.tagInfo = @"";
        
        model.cellModelArray = @[cellModel1,cellModel2,cellModel3,cellModel4];
    }
    
    return model;
}

@end

@interface LevelInfoCell ()

@property (nonatomic, strong) UILabel *label_index;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_text;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *tag_icon;
@property (nonatomic, strong) UILabel *label_tag;
@end

@implementation LevelInfoCell

- (void)initUI{
    
    UIView *line_index = [UIView new];
    line_index.backgroundColor = rgb(252,218,198);
    [self addSubview:line_index];
    [line_index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(34);
    }];
    line_index.lz_setView.lz_cornerRadius(5);
    
    UILabel *label_index = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"01" textColor:rgb(255,81,0)];
    [self addSubview:label_index];
    [label_index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(line_index);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(15) text:@"收款返现" textColor:rgb(255,81,0)];
    [self addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line_index.mas_right).offset(5);
        make.top.mas_equalTo(10);
    }];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = rgb(252,218,198);
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(line_index.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(52);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
    }];
    bgView.lz_setView.lz_cornerRadius(5);
    
    UIImageView *icon = [UIImageView new];
    [bgView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
    
    UIImageView *tag_icon = [UIImageView viewWithImage:UIImageName(@"level_tag")];
    [bgView addSubview:tag_icon];
    [tag_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(67, 20));
    }];
    
    UILabel *label_tag = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"财富保障" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [tag_icon addSubview:label_tag];
    [label_tag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UILabel *label_text = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"text" textColor:rgb(255,81,0)];
    label_text.numberOfLines = 0;
    [bgView addSubview:label_text];
    [label_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(56);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    _label_index = label_index;
    _label_title = label_title;
    _label_text = label_text;
    _icon = icon;
    _tag_icon = tag_icon;
    _label_tag = label_tag;
}

- (void)setModel:(LevelInfoCellModel *)model{
    _model = model;
    
    _label_index.text = [NSString stringWithFormat:@"0%ld",model.index+1];
    _label_title.text = model.title;
    _label_text.text = model.text;
    
    if (model.imageName.length == 0) {
        [_label_text mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
        }];
        _icon.hidden = YES;
    }else{
        _icon.image = UIImageName(model.imageName);
    }
    
    if (model.tagInfo.length == 0) {
        _tag_icon.hidden = YES;
    }else{
        _label_tag.text = model.tagInfo;
    }
}

@end

@interface LevelInfoView ()

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *xybtn;
@property (nonatomic, strong) UIView *xyView;
@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation LevelInfoView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(255,81,0)];
    [self addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(18);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:LZWhiteColor forState:UIControlStateNormal];
    [self addSubview:btn];
    
    _label_title = label_title;
    _btn = btn;
    _btn.lz_setView.lz_cornerRadius(6);
    
    [btn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //协议
    /*
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"点击升级即同意《六旺临门VIP协议》"];
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(33,33,33) range:NSMakeRange(0, attributedString.length)];
    
        // text-style1
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(7, 11)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(255,81,0) range:NSMakeRange(7, 11)];
    
    UILabel *label_xy = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(255,81,0)];
    [self addSubview:label_xy];
    [label_xy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    label_xy.attributedText = attributedString;
    
    UIButton *btn1 = [UIButton buttonWithFontSize:14 text:@"" textColor:rgb(53, 53, 53)];
    [self addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(label_xy);
        make.size.mas_equalTo(label_xy);
    }];

    [btn1 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
     */
    
    UIView *xyView = [UIView new];
    [self addSubview:xyView];
    [xyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    _xyView = xyView;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"同意《升级协议》及其服务条款"];
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(33,33,33) range:NSMakeRange(0, attributedString.length)];
    
        // text-style1
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(2, 6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(255,81,0) range:NSMakeRange(2, 6)];
    
    UILabel *label_xy = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(255,81,0)];
    [xyView addSubview:label_xy];
    [label_xy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    label_xy.attributedText = attributedString;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:UIImageName(@"board_unSelected") forState:UIControlStateNormal];
    [btn1 setImage:UIImageName(@"board_selected") forState:UIControlStateSelected];
    btn1.selected = YES;
    [xyView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(label_xy.mas_left).offset(-3);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(0);
    }];

    [btn1 addTouchAction:^(UIButton *sender) {
        sender.selected = !sender.isSelected;
    }];
    _xybtn = btn1;
    
    UIButton *btn2 = [UIButton buttonWithFontSize:14 text:@"" textColor:rgb(53, 53, 53)];
    [xyView addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_xy);
        make.left.mas_equalTo(label_xy).offset(40);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];

    [btn2 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick1{
    H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithUrl:@"http://admin.6wang666.com/new6wH5/html/userUpgradeAgreement.html"];
    PushController(h5);
    
}

- (void)submitClick{
    if (!_xybtn.isSelected) {
        [SVProgressHUD showInfoWithStatus:@"请先同意升级协议!"];
        return;
    }
    
    if (_model.submitBlock) {
        _model.submitBlock();
    }
}

- (void)setModel:(LevelInfoModel *)model{
    _model = model;
    
    _label_title.text = model.title;
    
    
    [_cellArray enumerateObjectsUsingBlock:^(LevelInfoCell  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [_cellArray removeAllObjects];
    
    UIView *lastView = _label_title;
    for (int i = 0; i < model.cellModelArray.count; i++) {
        LevelInfoCell *cell = [LevelInfoCell new];
        LevelInfoCellModel *cellModel = model.cellModelArray[i];
        cellModel.index = i;
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lastView.mas_bottom).offset(5);
            make.height.mas_greaterThanOrEqualTo(81);
        }];
        cell.model = cellModel;
        
        [self.cellArray addObject:cell];
        
        lastView = cell;
    }
    
    [_btn setTitle:model.btnTitle forState:UIControlStateNormal];
    [_btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-40);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(45);
    }];
    
    if (model.isBtnAble) {
        [_btn setDefaultGradientWithCornerRadius:6];
    }else{
        [_btn clearGradient];
        _btn.backgroundColor = rgb(101,101,101);
    }
    _btn.enabled = model.isBtnAble;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    self.lz_setView.lz_shadow(5, rgba(255, 81, 0, 0.19), CGSizeMake(0, 1), 1, 12);
    
    _xyView.hidden = model.type == LevelInfoTypeAreaServer;
}

- (NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

@end
