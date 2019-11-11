//
//  EditTagCollectionCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditTagCollectionCell.h"
#import "EditShopTagsModel.h"

@implementation EditTagCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:rgb(238,238,238) forState:UIControlStateNormal];
        [button setBackgroundColor:rgb(255,81,0) forState:UIControlStateSelected];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        button.titleLabel.font = Font_PingFang_SC_Medium(12);
        button.userInteractionEnabled = NO;
        
        _button = button;
        
    }
    return self;
}

- (void)setModel:(EditShopTagsModel *)model{
    _model = model;
    
    [_button setTitle:model.structDesc forState:UIControlStateNormal];
    _button.selected = model.isSelected;
    
    if (self.model.type == EditShopTagsTypeAdd) {//自定义
        [_button setImage:UIImageName(@"edit_tags_add") forState:UIControlStateNormal];
        [_button setTitleColor:rgb(255,81,0) forState:UIControlStateNormal];
        
    }else if (self.model.type == EditShopTagsTypeTag) {//tag
        [_button setTitleColor:rgb(53,53,53) forState:UIControlStateNormal];
        [_button setTitleColor:LZWhiteColor forState:UIControlStateSelected];
        [_button setImage:UIImageName(@"") forState:UIControlStateNormal];
        @weakify(self);
        [[RACObserve(model, isSelected) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.button.selected = model.isSelected;
        }];
    }
    
    
    
    
}


@end
