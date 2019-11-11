//
//  MarketMessageMoneyView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessageMoneyView.h"

@implementation MarketMessageMoneyModel
@end

@implementation MarketMessageMoneyCell

- (instancetype)init{
    self = [super init];
    if (self) {
        
        UILabel *lab = [UILabel labelWithFontSize:16 text:@"10" textColor:rgb(101,101,101)];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        _label_money = lab;
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(16);
        }];
        
        UILabel *lab2 = [UILabel labelWithFontSize:12 text:@"10" textColor:rgb(101,101,101)];
        lab2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab2];
        _label_info = lab2;
        
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lab.mas_bottom).offset(5);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(16);
        }];
        
        
    }
    return self;
}

- (void)setModel:(MarketMessageMoneyModel *)model{
    _model = model;
    
    _label_money.text = [NSString stringWithFormat:@"%@元",model.money];
    _label_info.text = [NSString stringWithFormat:@"(短信%@条)",model.count];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        _label_money.textColor = LZWhiteColor;
        _label_info.textColor = LZWhiteColor;
    }else{
        _label_money.textColor = rgb(101,101,101);
        _label_info.textColor = rgb(101,101,101);
    }
}

@end

@interface MarketMessageMoneyView ()
@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation MarketMessageMoneyView

- (void)initUI{
    
    UILabel *lab = [UILabel labelWithFontSize:13 text:@"充值短信条数" textColor:rgb(152,152,152)];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.height.mas_equalTo(16);
    }];
    
    self.backgroundColor = LZWhiteColor;
    
}

- (void)setDataArray:(NSArray<MarketMessageMoneyModel *> *)dataArray{
    _dataArray = dataArray;
    
    if (self.cellArray.count < dataArray.count) {
        NSInteger needCount = dataArray.count - self.cellArray.count;
        
        for (int i = 0; i < needCount; i++) {
            MarketMessageMoneyCell *cell = [MarketMessageMoneyCell new];
            [self.cellArray addObject:cell];
            [self addSubview:cell];
        }
    }
    
    [self.cellArray enumerateObjectsUsingBlock:^(MarketMessageMoneyCell  *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.hidden = YES;
    }];
    
    int maxCount = 3;
    CGFloat topY = 15;
    CGFloat leftX = 15;
    
    CGFloat btnW = (kScreenWidth-leftX*(maxCount+1))/maxCount;
    CGFloat btnH =  btnW *0.6;
    
    MarketMessageMoneyCell  *lastCell = nil;
    for (int i = 0; i < dataArray.count; i++) {
        MarketMessageMoneyCell  *cell = self.cellArray[i];
        cell.hidden = NO;
        
        MarketMessageMoneyModel *model = dataArray[i];
        cell.model = model;
        
        if (i%maxCount == 0) {
            [cell mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftX);
                make.size.mas_equalTo(CGSizeMake(btnW, btnH));
                
                if (lastCell) {
                    make.top.mas_equalTo(lastCell.mas_bottom).offset(topY);
                }else{
                    make.top.mas_equalTo(42);
                }
                
                if (i == dataArray.count-1) {
                    make.bottom.mas_equalTo(-15);
                }
            }];
        }else{
            [cell mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastCell.mas_right).offset(leftX);
                make.size.mas_equalTo(CGSizeMake(btnW, btnH));
                make.top.mas_equalTo(lastCell);
                
                if (i == dataArray.count-1) {
                    make.bottom.mas_equalTo(-15);
                }
            }];
        }
        
        [cell addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        lastCell = cell;
    }
    
    [self layoutIfNeeded];
    [self.cellArray enumerateObjectsUsingBlock:^(MarketMessageMoneyCell  *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.lz_setView.lz_cornerRadius(7).lz_border(0.5, rgba(0, 0, 0, 0.14));
    }];
}


- (void)btnClick:(MarketMessageMoneyCell *)cell{
    if (cell.isSelected) {
        cell.selected = NO;
        [cell.gradientLayer removeFromSuperlayer];
        cell.layer.borderWidth = 1;
        cell.selected = NO;
        
        if (_delegate && [_delegate respondsToSelector:@selector(lz_moneyViewClearChoice:)]) {
            [_delegate lz_moneyViewClearChoice:self];
        }
        
        return;
    }
    
    cell.selected = YES;
    cell.layer.borderWidth = 0;
    [cell setDefaultGradientWithCornerRadius:cell.layer.cornerRadius];
    
    [_cellArray enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != cell) {
            [obj.gradientLayer removeFromSuperlayer];
            obj.layer.borderWidth = 1;
            obj.selected = NO;
        }
    }];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(lz_view:atIndex:model:)]) {
        NSInteger index = [self.cellArray indexOfObject:cell];
        [_delegate lz_view:self atIndex:index model:cell.model];
    }
}


- (void)clearSelectedCell{
    for (MarketMessageMoneyCell *cell in _cellArray) {
        if (cell.isSelected) {
            [self btnClick:cell];
        }
    }
}

- (NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

@end
