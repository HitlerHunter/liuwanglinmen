//
//  CouponCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponCell.h"
#import "CouponCardView.h"
#import "CouponModel.h"

@interface CouponCell ()

@property (nonatomic, strong) CouponCardView *cardView;
@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, assign) CGFloat corTopY;
@property (nonatomic, assign) CGFloat radius;
@end

@implementation CouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = LZBackgroundColor;
        [self creatCardBgView];
    }
    return self;
}


- (void)creatCardBgView{
    
    _cardView = [CouponCardView new];
    [self.contentView addSubview:_cardView];
    
    [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 15, 10, 15));
    }];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setImage:UIImageName(@"coupon_unSelected") forState:UIControlStateNormal];
    [_selectBtn setImage:UIImageName(@"coupon_selected") forState:UIControlStateSelected];
    _selectBtn.hidden = YES;
    [self.contentView addSubview:_selectBtn];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.cardView.mas_right);
        make.top.bottom.mas_equalTo(self.cardView);
    }];
    _selectBtn.userInteractionEnabled = NO;
   
}

- (void)setModel:(CouponModel *)model{
    _model = model;
    _cardView.model = model;
}

- (void)setCanSelected:(BOOL)canSelected{
    _canSelected = canSelected;
    
    if (canSelected) {
        [_cardView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 5, 10, 45));
        }];
        _selectBtn.hidden = NO;
        
    }
}

- (BOOL)isSelected{
    return _selectBtn.isSelected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    _selectBtn.selected = selected;
}

@end
