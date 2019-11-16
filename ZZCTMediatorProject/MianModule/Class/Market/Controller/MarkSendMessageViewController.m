//
//  MarkSendMessageViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarkSendMessageViewController.h"
#import "MarketBoardView.h"
#import "MarkMessageChoicePersonView.h"

@interface MarkSendMessageViewController ()

@property (nonatomic, strong) MarkMessageChoicePersonView *topView;
@property (nonatomic, strong) MarketBoardView *mineBoard;
@property (nonatomic, strong) NSMutableArray *mineBoardArray;

@property (nonatomic, strong) MarketBoardCellModel *selecetdBoardModel;
@end

@implementation MarkSendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"短信群发";
    
    [self.view addSubview:self.scrollView];
    
    _topView = [MarkMessageChoicePersonView new];
    [self.scrollView addSubview:_topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(43);
    }];
    
    [self initBoard2];
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"短信模板" textColor:rgb(53,53,53)];
    [self.scrollView addSubview:label_name];
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.mineBoard.mas_top).offset(-7);
    }];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"发送" font:nil color:nil block:^{
        @strongify(self);
        [self sendMessage];
    }];
}

- (void)initBoard2{
    
    _mineBoard = [MarketBoardView new];
    _mineBoard.label_title.text = @"自定义模板";
    _mineBoard.backgroundColor = LZWhiteColor;
    _mineBoard.createBoardBtn.hidden = NO;
    _mineBoard.imageView_statu.image = UIImageName(@"board_mine_icon");
    [self.scrollView addSubview:_mineBoard];
    
    [_mineBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(40);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_greaterThanOrEqualTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    [self getMineBoardData];
    
    @weakify(self);
    [RACObserve([MarketBoardManager shareInstance], changed) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self getMineBoardData];
    }];
}

- (void)getMineBoardData{
    
    _mineBoardArray = [[MarketBoardManager shareInstance] getMineBoardArrayWithOutUnpassByType:MarketPlanTypeCustomString];
    
    @weakify(self);
    for (MarketBoardCellModel *boardModel in _mineBoardArray) {
        boardModel.cellType = MarketBoardCellTypeSelect;
        boardModel.block = ^(MarketBoardCellModel * _Nonnull model) {//选中
           @strongify(self);
            
            model.isSelected = YES;
            self.selecetdBoardModel = model;
            
            [self.mineBoardArray enumerateObjectsUsingBlock:^(MarketBoardCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model != obj) {
                    obj.isSelected = NO;
                }
            }];
            
        };
    }
    
    _mineBoard.boardArray = self.mineBoardArray;
}


- (void)sendMessage{
    
    if ([MarketMessageManager shareInstance].messageCount == 0) {
        [SVProgressHUD showErrorWithStatus:@"短信条数不足!"];
        return;
    }
    
    if (self.selecetdBoardModel == nil) {
        [self showMessage:@"请选择模板"];
        return;
    }

    NSString *personType = _topView.personType;
    
    if (personType.length == 0) {
        [self showMessage:@"请选择发送对象"];
        return;
    }
    
    NewParams;
    
    [params setSafeObject:MarketPlanTypeCustomString forKey:@"taskType"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"usrNo"];
    [params setSafeObject:@"1" forKey:@"taskStatus"];
    
    [params setSafeObject:personType forKey:@"sendTargetType"];
    [params setSafeObject:@"disposable" forKey:@"executeType"];
    
    [params setSafeObject:self.selecetdBoardModel.Id forKey:@"sendTemplateId"];
    [params setSafeObject:self.selecetdBoardModel.templateHead forKey:@"sendHead"];
    [params setSafeObject:self.selecetdBoardModel.templateContent forKey:@"sendContent"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"/outside-biz/smsMarketingTask")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            [SVProgressHUD showSuccessWithStatus:@"创建任务成功"];
            [self lz_popController];
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

@end
