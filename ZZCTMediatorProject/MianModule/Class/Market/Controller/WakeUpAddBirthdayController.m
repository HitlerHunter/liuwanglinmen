//
//  WakeUpAddBirthdayController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "WakeUpAddBirthdayController.h"
#import "WakeUpAddBirthdayTopView.h"
#import "MarketBoardView.h"

@interface WakeUpAddBirthdayController ()
@property (nonatomic, assign) MarketPlanType planType;
@property (nonatomic, strong) WakeUpAddBirthdayTopView *topView;
@property (nonatomic, strong) MarketBoardView *publicBoard;
@property (nonatomic, strong) MarketBoardView *mineBoard;
@property (nonatomic, strong) MarketBoardCellModel *selecetdBoardModel;

@property (nonatomic, strong) NSMutableArray *publicBoardArray;
@property (nonatomic, strong) NSMutableArray *mineBoardArray;

@property (nonatomic, strong) NSString *type;
@end

@implementation WakeUpAddBirthdayController

- (instancetype)initWithMarketPlanType:(MarketPlanType)type{
    self = [super init];
    if (self) {
        _planType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_planType==MarketPlanTypeWakeUp) {
        _type = MarketPlanTypeWakeUpString;
        self.title = @"会员唤醒";
    }else{
        _type = MarketPlanTypeBirthdayString;
        self.title = @"生日祝福";
    }
    
    [self.view addSubview:self.scrollView];
    
    _topView = [WakeUpAddBirthdayTopView new];
    [self.scrollView addSubview:_topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(85);
    }];
    
//    [self initBoard1];
    [self initBoard2];
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"短信模板" textColor:rgb(53,53,53)];
    [self.scrollView addSubview:label_name];
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.mineBoard.mas_top).offset(-7);
    }];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"保存" font:nil color:nil block:^{
        @strongify(self);
        [self save];
    }];
    
    if (_planType == MarketPlanTypeBirthday) {
        _topView.label_bottomLeft.text = @"向";
        _topView.label_bottomRight.text = @"天后，过生日会员发送短信";
        
    }
    

}


- (void)initBoard1{
    
    _publicBoard = [MarketBoardView new];
    _publicBoard.backgroundColor = LZWhiteColor;
    _publicBoard.label_title.text = @"公共模板";
    _publicBoard.label_status.text = @"（官方定义，不可操作）";
    _publicBoard.imageView_statu.image = UIImageName(@"board_pulic_icon");
    [self.scrollView addSubview:_publicBoard];
    
    [_publicBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(40);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    _publicBoardArray = [[MarketBoardManager shareInstance] getPublicBoardArrayWithType:_type];
    
    @weakify(self);
    [_publicBoardArray enumerateObjectsUsingBlock:^(MarketBoardCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.cellType = MarketBoardCellTypeSelect;
        
        obj.block = ^(MarketBoardCellModel * _Nonnull model) {//选中
            @strongify(self);
            model.isSelected = YES;
            self.selecetdBoardModel = model;
            [self.publicBoardArray enumerateObjectsUsingBlock:^(MarketBoardCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model != obj) {
                    obj.isSelected = NO;
                }
            }];
            
            [self.mineBoardArray enumerateObjectsUsingBlock:^(MarketBoardCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model != obj) {
                    obj.isSelected = NO;
                }
            }];
            
        };
    }];
    
    
    
    _publicBoard.boardArray = _publicBoardArray;
}

- (void)initBoard2{
    
    _mineBoard = [MarketBoardView new];
    _mineBoard.label_title.text = @"自定义模板";
    _mineBoard.backgroundColor = LZWhiteColor;
    _mineBoard.createBoardBtn.hidden = NO;
    _mineBoard.imageView_statu.image = UIImageName(@"board_mine_icon");
    [self.scrollView addSubview:_mineBoard];
    
    [_mineBoard mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.publicBoard.mas_bottom).offset(10);
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
    
    _mineBoardArray = [[MarketBoardManager shareInstance] getMineBoardArrayWithOutUnpassByType:_type];
    
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
            
            [self.publicBoardArray enumerateObjectsUsingBlock:^(MarketBoardCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model != obj) {
                    obj.isSelected = NO;
                }
            }];
        };
    }
    
    _mineBoard.boardArray = self.mineBoardArray;
}


- (void)save{
    
    if ([MarketMessageManager shareInstance].messageCount == 0) {
        [SVProgressHUD showErrorWithStatus:@"短信条数不足!"];
        return;
    }
    
    NSString *perdayTime = [_topView.time stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *delayDay = _topView.day;
    
    if (perdayTime.length == 0) {
        [self showMessage:@"请选择每天发送时间"];
        return;
    }
    
    if (delayDay.length == 0) {
        [self showMessage:@"请输入天数"];
        return;
    }
    
    if (self.selecetdBoardModel == nil) {
        [self showMessage:@"请选择模板"];
        return;
    }
    
    NewParams;
    [params setSafeObject:MarketPlanTypeBirthdayString forKey:@"taskType"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"usrNo"];
    [params setSafeObject:@"1" forKey:@"taskStatus"];
    [params setSafeObject:@"direct" forKey:@"sendTargetType"];
    [params setSafeObject:@"regular" forKey:@"executeType"];//定期
    [params setSafeObject:delayDay forKey:@"delayDay"];
    [params setSafeObject:perdayTime forKey:@"executeTime"];
    
    [params setSafeObject:self.selecetdBoardModel.Id forKey:@"sendTemplateId"];
    [params setSafeObject:self.selecetdBoardModel.templateHead forKey:@"sendHead"];
    [params setSafeObject:self.selecetdBoardModel.templateContent forKey:@"sendContent"];
    
//    [params setSafeObject:getMarketBoardTypeTitleWithTypeStr(self.selecetdBoardModel.targetType) forKey:@"sendTarge"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"/outside-biz/smsMarketingTask")
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

/*
 CREATE TABLE `tb_sms_task` (
 `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
 `user_id` int(11) DEFAULT NULL COMMENT '商户用户id',
 `sms_type` varchar(32) DEFAULT NULL COMMENT '短信类型：birthday:生日  rouse:会员唤醒  custom:自定义',
 `execute_type` varchar(32) DEFAULT NULL COMMENT '执行类型:regular:定期  disposable：一次性',
 `delay_day` int(11) DEFAULT NULL COMMENT '延迟天数',
 `task_status` int(11) DEFAULT NULL COMMENT '订单状态 1：执行中  2：执行成功  3：失败终止',
 `perday_time` varchar(32) DEFAULT NULL COMMENT '每日时间',
 `before_date` varchar(32) DEFAULT NULL COMMENT '上一次执行日期YYYYYMMdd',
 `send_targe_type` varchar(256) DEFAULT NULL COMMENT '目标类型 tag:标签分组用户 vip:创业 all:名下所有用户',
 `send_targe` varchar(256) DEFAULT NULL COMMENT '发送目标',
 `send_template_id` int(11) DEFAULT NULL COMMENT '发送模板id',
 `send_head` varchar(32) DEFAULT NULL COMMENT '短信头',
 `send_content` varchar(128) DEFAULT NULL COMMENT '订单内容',
 `send_times` int(11) DEFAULT NULL COMMENT '任务执行次数',
 `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
 `create_time` datetime DEFAULT NULL COMMENT '下单时间',
 `del_flag` int(11) DEFAULT '0' COMMENT '删除标识 0：正常 1：删除',
 `reason` varchar(64) DEFAULT NULL COMMENT '原因',
 `remark` varchar(32) DEFAULT NULL COMMENT '备注',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
 
 */
