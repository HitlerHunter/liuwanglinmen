//
//  FilterCollectionViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "FilterCollectionViewCell.h"
#import "FilterModel.h"

@interface FilterCollectionViewCell ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation FilterCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.btn];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(self.contentView).offset(0);
        }];
        
        self.lz_setView.lz_cornerRadius(10).lz_border(0.5, [UIColor blackColor]);
        self.contentView.backgroundColor = [UIColor whiteColor];
        @weakify(self);
        [self.btn addTouchAction:^(UIButton *sender) {
            @strongify(self);
            if (self.clickBlock) {
                self.clickBlock(self.model);
            }
        }];
    }
    return self;
}

- (void)setModel:(FilterModel *)model{
    _model = model;
    
    [self.btn setTitle:model.title forState:UIControlStateNormal];
    self.btn.selected = model.isSelected;
    self.layer.borderWidth = model.isSelected?0:0.5;
    
    @weakify(self);
    [[RACObserve(model, isSelected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.btn.selected = model.isSelected;
        self.layer.borderWidth = model.isSelected?0:0.5;
    }];
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.titleLabel.font = kfont(14);
        [_btn setTitleColor:UIColorHex(0x585858) forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btn setBackgroundColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    
    return _btn;
}

@end
