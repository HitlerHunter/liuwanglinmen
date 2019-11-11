//
//  CouponVipSectionHeaderView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponVipSectionHeaderView.h"
#import "CouponVipModel.h"

@interface CouponVipSectionHeaderView ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *chioceBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CouponVipSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *view = [UIView new];
        view.backgroundColor = LZBackgroundColor;
        self.backgroundView = view;
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.userInteractionEnabled = NO;
    [leftBtn setImage:UIImageName(@"coupon_unshow") forState:UIControlStateNormal];
    [leftBtn setImage:UIImageName(@"coupon_show") forState:UIControlStateSelected];
    
    [self.contentView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(32);
    }];
    
    
    UILabel *title_label = [UILabel labelWithFontSize:15 textColor:rgb(53,53,53)];
    [self.contentView addSubview:title_label];
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftBtn.mas_right);
        make.centerY.mas_equalTo(self);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:UIImageName(@"coupon_unSelected") forState:UIControlStateNormal];
    [rightBtn setImage:UIImageName(@"coupon_selected") forState:UIControlStateSelected];
    
    [self.contentView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(32);
    }];
    
    _leftBtn = leftBtn;
    _titleLabel = title_label;
    _chioceBtn = rightBtn;
    
    
    [rightBtn addTarget:self action:@selector(selectBtnTap) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSection)];
    [self addGestureRecognizer:tap];
}

//点击选中或取消选中
- (void)selectBtnTap{
    if (_didChangeChoiceBlock) {
        _didChangeChoiceBlock(self.model);
    }
}

//点击收起
- (void)showSection{
    self.model.isShow = !self.model.isShow;
    self.leftBtn.selected = self.model.isShow;
}

- (void)setModel:(CouponVipSectionModel *)model{
    _model = model;
    
    _leftBtn.selected = model.isShow;
    _chioceBtn.selected = model.isSelected;
    _titleLabel.text = model.tagsName;
    
    @weakify(self);
    [[RACObserve(model, isSelected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.chioceBtn.selected = model.isSelected;
    }];
}

@end
