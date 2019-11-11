//
//  SKViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SKViewController.h"
#import "SKRemarkViewController.h"
#import "SPKeyBoard.h"
#import "CTMediator+ModuleScanActions.h"

@interface SKViewController ()<SPKeyBoardProtocol>
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) SPKeyBoard *keyBoard;
@property (nonatomic, strong) NSString *remark;
@end

@implementation SKViewController

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收款";
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = LZBackgroundColor;
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = LZWhiteColor;
    _view1 = view1;
    [self.scrollView addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(160);
    }];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = LZBackgroundColor;
    _view2 = view2;
    [self.scrollView addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom);
        make.left.right.mas_equalTo(self.scrollView);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(self.scrollView);
    }];
    
    
    [self addUIView1];
    [self addUIView2];
    
    self.nameLabel.text = CurrentUserMerchant.pmsMerchantInfo.shortMerchantName;
    
    SPKeyBoard *keyBoard = [[SPKeyBoard alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 274*LZScale)];
    keyBoard.inputView = _moneyLabel;
    keyBoard.delegate = self;
    _keyBoard = keyBoard;
    [self.view addSubview:keyBoard];
    
    [keyBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(274*LZScale);
        make.bottom.mas_equalTo(self.view);
    }];
    
    _remark = @"";
//    @weakify(self);
//    [self addRightItemWithImage:@"sk_beizhu" title:@"备注" font:nil color:nil block:^{
//        @strongify(self);
//        SKRemarkViewController *remarkVC = [[SKRemarkViewController alloc] initWithBlock:^(NSString * _Nonnull text) {
//            self.remark = text;
//        }];
//        PushController(remarkVC);
//    }];
}

- (void)addUIView1{
    UILabel *label = [UILabel labelWithFontSize:15];
    label.textColor = rgb(101,101,101);
    self.nameLabel = label;
    [self.view1 addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view1);
        make.top.mas_equalTo(15);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(229,229,229);
    [self.view1 addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(42);
    }];
    
    UILabel *label2 = [UILabel labelWithFontSize:16];
    label2.text = @"收款金额";
    [self.view1 addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(13);
        make.left.mas_equalTo(15);
    }];
    
    UILabel *label1 = [UILabel labelWithFontSize:36 text:@"0.00" textColor:LZOrangeColor];
    [self.view1 addSubview:label1];
    _moneyLabel = label1;
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-26);
        make.right.mas_equalTo(-16);
    }];
    
    UILabel *label3 = [UILabel labelWithFontSize:15];
    label3.text = @"￥";
    [self.view1 addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label1.mas_bottom);
        make.left.mas_equalTo(15);
    }];
    
}

- (void)addUIView2{
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(229,229,229);
    [self.view2 addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.mas_equalTo(self.view2);
        make.height.mas_equalTo(1);
    }];
    
    NSArray *iocnArray = @[@"zhifubao",@"wechat"];
    
    UIView *view = [UIView new];
    view.backgroundColor = LZBackgroundColor;
    for (int i = 0; i < iocnArray.count; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = UIImageName(iocnArray[i]);
        imageView.frame = CGRectMake((i+1)*20+18*i, 0, 18, 18);
        imageView.centerY = 20;
        [view addSubview:imageView];
    }
    
    [self.view2 addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view2);
        make.size.mas_equalTo(CGSizeMake((iocnArray.count+1)*33, 40));
    }];
}


- (void)makeSureWithNumber:(NSString *)number{
    
    UIViewController *scanVC = [[CTMediator sharedInstance] CTMediator_ScanViewControllerWithMoney:number remark:self.remark];
    PushIdController(scanVC, LinearBackId_Scan);
    
    [_keyBoard setNumber:@"0.00"];
}
@end
