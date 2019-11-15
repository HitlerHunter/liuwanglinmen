//
//  MessageSendRecordDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageSendRecordDetailViewController.h"
#import "VipPersonDetailCellView.h"
#import "MessageSendRecordModel.h"
#import "MessageTaskViewModel.h"

@interface MessageSendRecordDetailViewController ()

@property (nonatomic, strong) VipPersonDetailCellView *cellView1;
@property (nonatomic, strong) MessageSendRecordModel *model;
@property (nonatomic, strong) MessageTaskViewModel *viewModel;

@property (nonatomic, strong) UIButton *stopBtn;
@end

@implementation MessageSendRecordDetailViewController

- (instancetype)initWithModel:(MessageSendRecordModel *)model viewModel:(MessageTaskViewModel *)viewModel{
    self = [self init];
    if (self) {
        _model = model;
        _viewModel = viewModel;
//        _model.taskStatus = MessageSendRecordStatusSending;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"记录详情";
    
    [self.view addSubview:self.scrollView];
    
    [self initCellView1];
    [self addStopRemoveBtn];
    
    [self requestDetailData];
}

- (void)initCellView1{
    
    _cellView1 = [VipPersonDetailCellView new];
//    _cellView1.dataArray = [self creatDataArray];
    [self.scrollView addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(kScreenWidth-30);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-135);
    }];
    
    _cellView1.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
    
}

- (void)addStopRemoveBtn{
    
    UIButton *stopBtn = [UIButton buttonWithFontSize:16 text:@"终止" textColor:LZWhiteColor];
    [self.scrollView addSubview:stopBtn];
    
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(30);
    }];
    
    [stopBtn setDefaultGradientWithCornerRadius:6];
    [stopBtn addTarget:self action:@selector(showStopAlert) forControlEvents:UIControlEventTouchUpInside];

    _stopBtn = stopBtn;
    
    [self checkStopBtn];
}

- (void)checkStopBtn{
    //待发送的显示
    if (_model.taskStatus == MessageSendRecordStatusSending) {
        _stopBtn.hidden = NO;
        [_stopBtn setTitle:@"终止" forState:UIControlStateNormal];
    }else {
        _stopBtn.hidden = YES;
    }
}

- (void)showStopAlert{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否终止发送?" message:@"终止后不可恢复！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *man = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *woman = [UIAlertAction actionWithTitle:@"终止" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self stopPlan];
    }];
    [alertVC addAction:man];
    [alertVC addAction:woman];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)stopPlan{
    
    MessageSendRecordModel *model = _model.modelCopy;
    //终止
    model.taskStatus = MessageSendRecordStatusSendPause;
    
    [SVProgressHUD show];
    [MessageTaskViewModel editTask:model returnBlock:^(BOOL isSuccess) {
        [SVProgressHUD dismiss];
        if (isSuccess) {
            self.model.taskStatus = model.taskStatus;
            
            [self checkStopBtn];
            //成功 提示 刷新
            [[NSNotificationCenter defaultCenter] postNotificationName:MessageSendRecordNeedRefreshNotificationName object:nil];
            [SVProgressHUD showSuccessWithStatus:@"已终止发送!"];
        }
    }];
}


- (void)requestDetailData{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"/outside-biz/smsMarketingLog/%@",_model.Id];
    
    ZZNetWorker.GET.zz_param(@{}).zz_url(urlStr)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            self.model.remark = model_net.data[@"remark"];
            self.model.sendSuccessCount = [NSString stringWithFormat:@"%@",model_net.data[@"sendSuccessCount"]];
            self.model.sendFailureCount = [NSString stringWithFormat:@"%@",model_net.data[@"sendFailureCount"]];
            
            if ([self.model.sendTargeType isEqualToString:@"all"]) {
                self.model.tagName =@"全部会员";
                self.cellView1.dataArray = [self creatDataArray];
            }else{
                [MessageTaskViewModel getTagNameWithId:self.model.sendTarge returnBlock:^(NSString * _Nonnull TagName) {
                    self.model.tagName = TagName;
                    self.cellView1.dataArray = [self creatDataArray];
                }];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取详情失败，请稍后再试"];
        }
    });
}

- (NSMutableArray * )creatVauleArray{
    
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    if (IsNull(_model.smsType)) {//发送类型
        [vauleArray addObject:@""];
    }else{
        [vauleArray addObject:getMessageSendTaskSMSTypeTitleWithSMSType(_model.smsType)];
    }
    
    [vauleArray addObject:self.model.tagName];//发送对象
    
    if (IsNull(_model.executeTime)) {//发送时间
        [vauleArray addObject:@""];
    }else{
        [vauleArray addObject:_model.executeTime];
    }
    
    //发送次数
    NSInteger allCount = _model.sendSuccessCount.integerValue + _model.sendFailureCount.integerValue;
    [vauleArray addObject:[NSString stringWithFormat:@"%ld",allCount]];
    
    if (IsNull(_model.sendSuccessCount)) {//发送成功次数
        [vauleArray addObject:@"0"];
    }else{
        [vauleArray addObject:_model.sendSuccessCount];
    }
    
    if (IsNull(_model.sendContent)) {//发送内容
        [vauleArray addObject:@""];
    }else{
        [vauleArray addObject:_model.sendContent];
    }
    
    return vauleArray;
}

- (NSMutableArray *)creatDataArray{
    
    NSArray *titleArray = @[@"发送类型",@"发送对象",@"发送时间",@"发送条数",@"成功发送条数",@"发送内容",];
    NSMutableArray *vauleArray = [self creatVauleArray];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        model.textAlignment = NSTextAlignmentRight;
        model.titleTextColor = rgb(152,152,152);
        model.vauleTextColor = rgb(53,53,53);
        
        if (i == titleArray.count-1) {
            model.cellStyle = VipPersonDetailCellStyleVauleBottom;
            model.textAlignment = NSTextAlignmentLeft;
        }
        
        [arr1 addObject:model];
    }
    return arr1;
}
@end
