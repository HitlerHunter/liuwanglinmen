//
//  CashSubmitViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/28.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "CashSubmitViewController.h"
#import "CashTitleInfoCell.h"

@interface CashSubmitViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cashMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel3;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end

@implementation CashSubmitViewController

- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _dic = dic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"提现";
    
    self.view.backgroundColor = LZWhiteColor;
    
    self.submit.lz_setView.lz_cornerRadius(5).lz_border(1, rgb(255,81,0));
    
    NSDate *date = [NSDate date];
    
    self.timeLabel1.text = [NSString stringWithFormat:@"%@ %@",[date formatYMDWithSeparate:@"-"],[date formatHMS]];
    
    date = [date dateByAddingTimeInterval:5];
    
    
    date = [date dateByAddingDays:3];
    self.timeLabel3.text = [NSString stringWithFormat:@"%@ %@",[date formatYMDWithSeparate:@"-"],[date formatHMS]];
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(152,152,152);
    [_leftView addSubview:line];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = rgb(255,81,0);
    [_leftView addSubview:view1];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = rgb(152,152,152);
    [_leftView addSubview:view2];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
    
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    view1.lz_setView.lz_cornerRadius(6);
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    view2.lz_setView.lz_cornerRadius(6);
    
    _leftView.backgroundColor = LZWhiteColor;
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = rgb(236,236,236);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(62);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    CashTitleInfoCell *cell1 = [CashTitleInfoCell cellWithTitle:@"提现金额" vaule:[NSString stringWithFormat:@"￥%@",self.dic[@"money"]]];
    CashTitleInfoCell *cell2 = [CashTitleInfoCell cellWithTitle:@"手续费" vaule:[NSString stringWithFormat:@"￥%@",self.dic[@"ssf"]]];
    CashTitleInfoCell *cell3 = [CashTitleInfoCell cellWithTitle:@"到账银行卡" vaule:self.dic[@"cardNo"]];
    
    cell1.valueLabel.textAlignment = NSTextAlignmentRight;
    cell2.valueLabel.textAlignment = NSTextAlignmentRight;
    cell3.valueLabel.textAlignment = NSTextAlignmentRight;
    
    NSArray *cellArray = @[cell1,cell2,cell3];
    
    UIView *lastView = nil;
    for (UIView *cell in cellArray) {
        [self.view addSubview:cell];
        
        if (!lastView) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(line2.mas_bottom).offset(5);
            }];
        }else {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(lastView.mas_bottom);
            }];
        }
        lastView = cell;
    }
//    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(0);
//    }];
    
    [[UserManager shareInstance] getUserWallet];
}


- (IBAction)back:(id)sender {
    [self lineBackWithId:LinearBackId_Cash];
}


@end
