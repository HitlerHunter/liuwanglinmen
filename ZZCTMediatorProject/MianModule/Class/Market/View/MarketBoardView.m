//
//  MarketBoardView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketBoardView.h"
#import "MarketBoardCell.h"
#import "MarketBoardCreateViewController.h"

@interface MarketBoardView ()
@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation MarketBoardView

- (void)initUI{
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"" textColor:rgb(53,53,53)];
   
    UILabel *label_statu = [UILabel labelWithFont:Font_PingFang_SC_Regular(13) text:@"" textColor:rgb(152,152,152)];
    UIImageView *imageView_statu = [UIImageView new];
    UIButton *createBoardBtn = [UIButton buttonWithFontSize:14 text:@"+创建模板" textColor:rgb(255,81,0)];
    createBoardBtn.hidden = YES;
    
    [self addSubview:label_name];
    [self addSubview:label_statu];
    [self addSubview:imageView_statu];
    [self addSubview:createBoardBtn];
    
    _label_title = label_name;
    _label_status = label_statu;
    _imageView_statu = imageView_statu;
    _createBoardBtn = createBoardBtn;
    
    [imageView_statu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView_statu);
        make.left.mas_equalTo(imageView_statu.mas_right).offset(3);
    }];
    
    [label_statu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView_statu);
        make.left.mas_equalTo(label_name.mas_right).offset(3);
    }];
    
    [createBoardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView_statu);
        make.right.mas_equalTo(-30);
    }];
    
    [createBoardBtn addTarget:self action:@selector(createBoard) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createBoard{
    MarketBoardCreateViewController *add = [[MarketBoardCreateViewController alloc] init];
    PushController(add);
}

- (void)setBoardArray:(NSArray<MarketBoardCellModel *> *)boardArray{
    _boardArray = boardArray;
    
    if (self.cellArray.count < boardArray.count) {
        NSInteger needCount = boardArray.count - self.cellArray.count;
        
        for (int i = 0; i < needCount; i++) {
            MarketBoardCell *cell = [MarketBoardCell new];
            [self.cellArray addObject:cell];
            [self addSubview:cell];
        }
    }
    
    [self.cellArray enumerateObjectsUsingBlock:^(MarketBoardCell  *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.hidden = YES;
        [cell mas_remakeConstraints:^(MASConstraintMaker *make) {}];
    }];
    
    MarketBoardCell  *lastCell = nil;
    for (int i = 0; i < boardArray.count; i++) {
        MarketBoardCell  *cell = self.cellArray[i];
        cell.hidden = NO;
        
        MarketBoardCellModel *model = boardArray[i];
        cell.model = model;
        
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_greaterThanOrEqualTo(50);
            
            if (lastCell) {
                make.top.mas_equalTo(lastCell.mas_bottom).offset(15);
            }else{
                make.top.mas_equalTo(40);
            }
            
            if (i == boardArray.count-1) {
                make.bottom.mas_equalTo(-15);
            }
        }];
        
        
        lastCell = cell;
    }
    
    [self layoutIfNeeded];
    [self.cellArray enumerateObjectsUsingBlock:^(MarketBoardCell  *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.lz_setView.lz_cornerRadius(2).lz_border(0.5, rgba(0, 0, 0, 0.14));
    }];
}


- (NSMutableArray *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

@end
