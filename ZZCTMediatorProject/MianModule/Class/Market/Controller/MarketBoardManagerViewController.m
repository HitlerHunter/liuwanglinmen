//
//  MarketBoardManagerViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketBoardManagerViewController.h"
#import "MarketBoardView.h"
#import "MarketBoardCreateViewController.h"

@interface MarketBoardManagerViewController ()
@property (nonatomic, strong) MarketBoardView *publicBoard;
@property (nonatomic, strong) MarketBoardView *mineBoard;
@end

@implementation MarketBoardManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"模板管理";
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"创建" font:nil color:nil block:^{
        @strongify(self);
        MarketBoardCreateViewController *add = [[MarketBoardCreateViewController alloc] init];
        PushController(add);
    }];
    
    [self.view addSubview:self.scrollView];
    
//    [self initBoard1];
    [self initBoard2];
    
}


- (void)initBoard1{
    
    _publicBoard = [MarketBoardView new];
    _publicBoard.backgroundColor = LZWhiteColor;
    _publicBoard.label_title.text = @"公共模板";
    _publicBoard.label_status.text = @"（官方定义，不可操作）";
    _publicBoard.imageView_statu.image = UIImageName(@"board_pulic_icon");
    [self.scrollView addSubview:_publicBoard];
    
    [_publicBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    _publicBoard.boardArray = [MarketBoardManager shareInstance].publicBoardArray;
}

- (void)initBoard2{
    
    _mineBoard = [MarketBoardView new];
    _mineBoard.label_title.text = @"自定义模板";
    _mineBoard.backgroundColor = LZWhiteColor;
    _mineBoard.imageView_statu.image = UIImageName(@"board_mine_icon");
    [self.scrollView addSubview:_mineBoard];
    
    [_mineBoard mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.publicBoard.mas_bottom).offset(10);
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_greaterThanOrEqualTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    [self refreshMineBoardData];
    
    @weakify(self);
    [RACObserve([MarketBoardManager shareInstance], changed) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self refreshMineBoardData];
    }];
}

- (void)refreshMineBoardData{
    
    for (MarketBoardCellModel *boardModel in [MarketBoardManager shareInstance].mineBoardArray) {
        @weakify(self);
        boardModel.cellType = MarketBoardCellTypeShow;
        boardModel.block = ^(MarketBoardCellModel * _Nonnull model) {
            @strongify(self);
            MarketBoardCreateViewController *edit = [[MarketBoardCreateViewController alloc] initWithBoardModel:model];
            PushController(edit);
        };
    }
    
    _mineBoard.boardArray = [MarketBoardManager shareInstance].mineBoardArray;
}

@end
