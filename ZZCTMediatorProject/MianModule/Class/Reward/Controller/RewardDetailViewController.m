//
//  RewardDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardDetailViewController.h"
#import "VipPersonDetailCellView.h"
#import "RewardRecordModel.h"

@interface RewardDetailViewController ()
@property (nonatomic, strong) RewardRecordModel *model;
@property (nonatomic, strong) VipPersonDetailCellView *cellView2;
@end

@implementation RewardDetailViewController

- (instancetype)initWithModel:(RewardRecordModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"记录详情";
    
    [self.view addSubview:self.scrollView];
    [self initCellView2];
}

- (void)initCellView2{
    //@"授权书照片",@"手持授权书照片",
    NSArray *titleArray = @[@"悬赏费率",@"申请时间",@"审核状态",@"失败原因",];
    
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    [vauleArray addObject:[NSString stringWithFormat:@"%ld%%",_model.shareComp13.integerValue/100]];
    [vauleArray addObject:_model.createTime];
    [vauleArray addObject:getStatusTitleWithStatus(_model.status_lz)];
    [vauleArray addObject:IsNull(_model.checkRemark)?@"":_model.checkRemark];
//    [vauleArray addObject:_model.rentalAgreement];
//    [vauleArray addObject:_model.handRentalAgreement];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        [arr1 addObject:model];
        
        model.textAlignment = NSTextAlignmentRight;
        
        if (i == 3) {
            model.cellStyle = VipPersonDetailCellStyleVauleBottom;
            model.textAlignment = NSTextAlignmentLeft;
        }else if (i == 4 || i == 5) {
            model.cellStyle = VipPersonDetailCellStyleVauleBottomImage;
        }
        
    }
    
    _cellView2 = [VipPersonDetailCellView new];
    _cellView2.dataArray = arr1;
    [self.scrollView addSubview:_cellView2];
    
    [_cellView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(kScreenWidth-30);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-15);
    }];
    
    _cellView2.lz_setView.lz_cornerRadius(6);
}

@end
