//
//  MarketMessagePayWayView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessagePayWayView.h"

@implementation MarketMessagePayWayModel

@end

@interface MarketMessagePayWayViewCell ()
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIImageView *selectImageView;
@end

@implementation MarketMessagePayWayViewCell

- (void)initUI{
    
    UIImageView *logo = [UIImageView new];
    [self addSubview:logo];
    
    UILabel *lab = [UILabel labelWithFontSize:13 text:@"" textColor:rgb(101,101,101)];
    [self addSubview:lab];
    
    UIImageView *selectImageView = [UIImageView new];
    selectImageView.image = UIImageName(@"board_unSelected");
    selectImageView.highlightedImage = UIImageName(@"board_selected");
    [self addSubview:selectImageView];
    
    _logo = logo;
    _label_title = lab;
    _selectImageView = selectImageView;
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logo.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
    }];
    
    [selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    self.backgroundColor = LZWhiteColor;
    
}

- (void)setModel:(MarketMessagePayWayModel *)model{
    _model = model;
    
    _logo.image = UIImageName(model.logo);
    _label_title.text = model.title;
    self.selectImageView.highlighted = model.isSeleceted;
    
    @weakify(self);
    [RACObserve(model, isSeleceted) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.selectImageView.highlighted = model.isSeleceted;
    }];
}

@end

@interface MarketMessagePayWayView ()
@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation MarketMessagePayWayView

- (void)initUI{
    
    UILabel *lab = [UILabel labelWithFontSize:13 text:@"支付方式" textColor:rgb(152,152,152)];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.height.mas_equalTo(16);
    }];
    
    self.backgroundColor = LZWhiteColor;
    
}

- (void)setDataArray:(NSArray<MarketMessagePayWayModel *> *)dataArray{
    _dataArray = dataArray;
    
    if (self.cellArray.count < dataArray.count) {
        NSInteger needCount = dataArray.count - self.cellArray.count;
        
        for (int i = 0; i < needCount; i++) {
            MarketMessagePayWayViewCell *cell = [MarketMessagePayWayViewCell new];
            [self.cellArray addObject:cell];
            [self addSubview:cell];
        }
    }
    
    [self.cellArray enumerateObjectsUsingBlock:^(MarketMessagePayWayViewCell  *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.hidden = YES;
    }];
    
    MarketMessagePayWayViewCell  *lastCell = nil;
    for (int i = 0; i < dataArray.count; i++) {
        MarketMessagePayWayViewCell  *cell = self.cellArray[i];
        cell.hidden = NO;
        
        MarketMessagePayWayModel *model = dataArray[i];
        cell.model = model;
        
        [cell mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(45);
            
            if (lastCell) {
                make.top.mas_equalTo(lastCell.mas_bottom);
            }else{
                make.top.mas_equalTo(32);
            }
            
            if (i == dataArray.count-1) {
                make.bottom.mas_equalTo(-5);
            }
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
        [cell addGestureRecognizer:tap];
        
        lastCell = cell;
    }
    
}


- (void)cellClick:(UITapGestureRecognizer *)tap{
    
    MarketMessagePayWayViewCell *cell = (MarketMessagePayWayViewCell *)tap.view;
    
    [_cellArray enumerateObjectsUsingBlock:^(MarketMessagePayWayViewCell * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != cell && obj.model.isSeleceted) {
            obj.model.isSeleceted = NO;
        }
    }];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(lz_messagePayWaySelectedAtIndex:model:)]) {
        NSInteger index = [self.cellArray indexOfObject:cell];
        [_delegate lz_messagePayWaySelectedAtIndex:index model:cell.model];
    }
}

- (NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

@end
