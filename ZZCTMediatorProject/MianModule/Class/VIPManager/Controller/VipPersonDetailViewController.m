//
//  VipPersonDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipPersonDetailViewController.h"
#import "VipPersonDetailCellView.h"
#import "VipPersonDetailTopView.h"
#import "VipConsumeRecordViewController.h"
#import "VipPersonModel.h"

@interface VipPersonDetailViewController ()<LDActionSheetDelegate>
@property (nonatomic, strong) VipPersonDetailTopView *topView;
@property (nonatomic, strong) VipPersonDetailCellView *cellView1;
@property (nonatomic, strong) VipPersonDetailCellView *cellView2;

@property (nonatomic, strong) VipPersonModel *model;
@end

@implementation VipPersonDetailViewController

- (instancetype)initWithModel:(VipPersonModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会员详情";
    [self.view addSubview:self.scrollView];
    
    _topView = [VipPersonDetailTopView new];
    [self.scrollView addSubview:_topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(kScreenWidth-30);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(80);
    }];
    
    _topView.lz_setView.lz_cornerRadius(6);
    
    
    [self initCellView1];
    [self initCellView2];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"更多" font:nil color:nil block:^{
        @strongify(self);
        [self showAlertView];
    }];
    
    _topView.headImage.image = [AppCenter defaultAppAvatar];
    _topView.label_name.text = _model.nickName;
    _topView.label_phone.text = [NSString stringWithFormat:@"会员ID:%@",_model.userId];
}

- (void)initCellView1{
    NSArray *titleArray = @[@"手机号码",@"性别",@"生日",];
    NSMutableArray *vauleArray = [NSMutableArray array];
    
   [vauleArray addObject:IsNull(_model.phone)?@"暂无":_model.phone.phoneTakeSecure];
    if ([_model.gendar isEqualToString:@"male"]) {
        [vauleArray addObject:@"男"];
    }else{
        [vauleArray addObject:@"女"];
    }
    
    [vauleArray addObject:IsNull(_model.birthday)?@"暂无":_model.birthday];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        
//        if (i == 0) {
//            model.canTap = YES;
//            model.hasIcon = YES;
//            model.tapImage = @"Phone";
//            @weakify(self);
//            model.clickBlock = ^(NSString * _Nonnull vauleStr) {
//                @strongify(self);
//                if(self.model.phone.length > 8) {
//                    [AppCenter callWithPhoneNumber:self.model.phone];
//                }else{
//                    [self showMessage:@"电话号码为空"];
//                }
//            };
//        }
        
        [arr1 addObject:model];
    }
    
    _cellView1 = [VipPersonDetailCellView new];
    _cellView1.dataArray = arr1;
    [self.scrollView addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(38);
    }];
    
    _cellView1.lz_setView.lz_cornerRadius(6);
    
    UILabel *label_info = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"基本信息" textColor:rgb(101,101,101)];
    [self.scrollView addSubview:label_info];
    
    [label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cellView1);
        make.bottom.mas_equalTo(self.cellView1.mas_top).offset(-4);
    }];
}

- (void)initCellView2{
    NSArray *titleArray = @[@"会员等级",@"会员分组",@"注册时间",@"消费次数",@"消费金额",@"最后一次消费时间",];
    
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    [vauleArray addObject:IsNull(_model.phone)?@"游客":@"会员"];
    [vauleArray addObject:IsNull(_model.tagName)?@"暂无":_model.tagName];
    [vauleArray addObject:_model.createTime];
    [vauleArray addObject:[NSString stringWithFormat:@"%@次",_model.payTimes]];
    [vauleArray addObject:[NSString stringWithFormat:@"%@元",[NSString formatFloatString:_model.totalPay]]];
    [vauleArray addObject:IsNull(_model.lastPayTime)?@"暂无":_model.lastPayTime];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        [arr1 addObject:model];
    }
    
    _cellView2 = [VipPersonDetailCellView new];
    _cellView2.dataArray = arr1;
    [self.scrollView addSubview:_cellView2];
    
    [_cellView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.cellView1);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(15);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-15);
    }];
    
    _cellView2.lz_setView.lz_cornerRadius(6);
}

- (void)showAlertView{
    LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"查看消费记录", nil];
    [sheet showInView:KeyWindow];
    
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        VipConsumeRecordViewController *recordVc = [[VipConsumeRecordViewController alloc] initWithModel:_model];
        PushController(recordVc);
    }
}

@end
