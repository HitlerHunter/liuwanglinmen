//
//  LevelUpAreaServerController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelUpAreaServerController.h"
#import "LevelUpSelecteCell.h"
#import "LevelUpInputCell.h"
#import "LZAddressCenter.h"
#import "LevelUpSuccessViewController.h"
#import "LevelUpViewModel.h"

@interface LevelUpAreaServerController ()<AddressSelectDelegate>

@property (nonatomic, strong) LevelUpInputCell *cell_name;
@property (nonatomic, strong) LevelUpSelecteCell *cell_area;
@property (nonatomic, strong) LevelUpInputCell *cell_phone;

@property (nonatomic, strong) LZAddressCenter *addressCenter;
@end

@implementation LevelUpAreaServerController

+ (LevelUpAreaServerController *)showAreaServerWithController:(UIViewController *)superController{
    LevelUpAreaServerController *vc = [LevelUpAreaServerController new];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    superController.definesPresentationContext = YES;
    [superController presentViewController:vc animated:YES completion:nil];
    
    return vc;
}

- (BOOL)willAddTap{
    return YES;
}

- (void)selfViewTap{
    [super selfViewTap];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *cardView = [UIView new];
    cardView.backgroundColor = LZWhiteColor;
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-40);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(305);
        make.height.mas_greaterThanOrEqualTo(300);
    }];
    cardView.lz_setView.lz_cornerRadius(8);
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(18) text:@"升级区域服务商" textColor:rgb(18,18,18)];
    [cardView addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    LevelUpInputCell *cell_name = [LevelUpInputCell cellWithTitle:@"姓名" placeholder:@"请输入姓名"];
    LevelUpInputCell *cell_phone = [LevelUpInputCell cellWithTitle:@"电话" placeholder:@"请输入联系电话"];
    @weakify(self);
    LevelUpSelecteCell *cell_area = [LevelUpSelecteCell cellWithTitle:@"地区" placeholder:@"请选择所在地区" block:^{
        @strongify(self);
        [LZAddressCenter gotoSelectAddressWithController:self];
    }];
    
    _cell_name = cell_name;
    _cell_phone = cell_phone;
    _cell_area = cell_area;
    
    NSArray *cellArray = @[cell_name,cell_area,cell_phone];
    
    UIView *lastView = nil;
    for (UIView *cell in cellArray) {
        [cardView addSubview:cell];
        
        if (!lastView) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(12);
                make.right.mas_equalTo(-12);
                make.top.mas_equalTo(57);
                make.height.mas_equalTo(44);
            }];
        }else {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(12);
                make.right.mas_equalTo(-12);
                make.height.mas_equalTo(44);
                make.top.mas_equalTo(lastView.mas_bottom).offset(15);
            }];
        }
        lastView = cell;
    }
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:16 text:@"立即抢位" textColor:LZWhiteColor];
    [cardView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.top.mas_equalTo(lastView.mas_bottom).offset(27);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(-28);
    }];
    [commitBtn setDefaultGradientWithCornerRadius:6];
    
    UIButton *kefuBtn = [UIButton buttonWithFontSize:16 text:[AppCenter KeFuPhone] textColor:rgb(19,17,16)];
    [cardView addSubview:kefuBtn];
    [kefuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.top.mas_equalTo(commitBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-28);
        make.bottom.mas_equalTo(-10);
    }];
    
    [kefuBtn addTouchAction:^(UIButton *sender) {
        [AppCenter callKeFu];
    }];
    
    [commitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
}

- (void)Center:(LZAddressCenter *)center
      Province:(NSString *)province
          city:(NSString *)city
      district:(NSString *)district{
    
    _cell_area.label_text.text = [NSString stringWithFormat:@"%@%@%@",province,city,district];
    self.addressCenter = center;
}

- (void)submit{
    
    NSString *name = _cell_name.textField.text;
    if (name.length == 0) {
        [self showMessage:@"请输入姓名!"];
        return;
    }
    
    NSString *area = _cell_area.label_text.text;
    if (area.length == 0) {
        [self showMessage:@"请选择地区!"];
        return;
    }
    
    NSString *phone = _cell_phone.textField.text;
    if (phone.length == 0) {
        [self showMessage:@"请输入联系电话!"];
        return;
    }
    
    [LevelUpViewModel upLevelWithMoney:self.money
                                  area:area
                                 level:@"3"
                                 phone:phone
                                  name:name block:^(id  _Nullable obj) {
                                      [self showMessage:@"抢位成功！"];
                                      [self selfViewTap];
    }];
    
    
}

@end
