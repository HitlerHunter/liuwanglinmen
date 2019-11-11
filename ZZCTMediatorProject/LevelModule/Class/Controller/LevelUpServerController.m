//
//  LevelUpServerController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelUpServerController.h"
#import "LevelUpSelecteCell.h"
#import "LevelUpInputCell.h"
#import "LevelUpSuccessViewController.h"

@interface LevelUpServerController ()

@property (nonatomic, strong) LevelUpInputCell *cell_name;
@property (nonatomic, strong) LevelUpSelecteCell *cell_area;

@end

@implementation LevelUpServerController

+ (void)showServerWithController:(UIViewController *)superController{
    LevelUpServerController *vc = [LevelUpServerController new];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    superController.definesPresentationContext = YES;
    [superController presentViewController:vc animated:YES completion:nil];
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
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(18) text:@"升级服务商" textColor:rgb(18,18,18)];
    [cardView addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    LevelUpInputCell *cell_name = [LevelUpInputCell cellWithTitle:@"姓名" placeholder:@"请输入姓名"];
    LevelUpSelecteCell *cell_area = [LevelUpSelecteCell cellWithTitle:@"地区" placeholder:@"请选择所在地区" block:^{
        
    }];
    
    _cell_name = cell_name;
    _cell_area = cell_area;
    
    NSArray *cellArray = @[cell_name,cell_area];
    
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
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:16 text:@"立即升级" textColor:LZWhiteColor];
    [cardView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.top.mas_equalTo(lastView.mas_bottom).offset(50);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(-28);
    }];
    [commitBtn setDefaultGradientWithCornerRadius:6];
    
    UILabel *label_money = [UILabel labelWithFont:Font_PingFang_SC_Medium(18) text:@"" textColor:rgb(18,18,18)];
    [cardView addSubview:label_money];
    [label_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(commitBtn.mas_top).offset(-10);
        make.left.mas_equalTo(cell_area);
        make.height.mas_equalTo(20);
    }];
    
    NSString *money = @"5000";
    NSString *str = [NSString stringWithFormat:@"应付 %@ 元",money];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:Font_PingFang_SC_Regular(16),NSForegroundColorAttributeName:rgb(19,17,16)}];
    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(246,84,25) range:NSMakeRange(2, money.length)];
    
    label_money.attributedText = attStr;
    
    
    [commitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
}

- (void)submit{
    [LevelUpSuccessViewController showSuccessWithController:self type:LevelUpSuccessTypeAlreadyVIP];
}

@end
