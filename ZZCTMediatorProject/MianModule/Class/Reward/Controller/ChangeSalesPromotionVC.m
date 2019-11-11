//
//  ChangeSalesPromotionVC.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/23.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ChangeSalesPromotionVC.h"
#import "RewardTopView.h"
#import "RewardSelectImageView.h"
#import "RewardViewModel.h"

@interface ChangeSalesPromotionVC ()

@property (nonatomic, strong) RewardTopView *topView;
@property (nonatomic, strong) RewardSelectImageView *view1;
@property (nonatomic, strong) RewardSelectImageView *view2;
@property (nonatomic, strong) UIButton *btnAgree;

@property (nonatomic, assign) BOOL isNotHiddenBar;
@end

@implementation ChangeSalesPromotionVC

- (instancetype)initWithNotHiddenNavgationBar:(BOOL)isNotHiddenBar{
    self = [super init];
    if (self) {
        _isNotHiddenBar = isNotHiddenBar;
    }
    return self;
}

- (BOOL)hiddenNavgationBar{
    return !_isNotHiddenBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"悬赏";
    self.view.backgroundColor = LZWhiteColor;
    self.scrollView.backgroundColor = LZWhiteColor;
    [self.view addSubview:self.scrollView];

    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    topLine.backgroundColor = LZBackgroundColor;
    [self.scrollView addSubview:topLine];
    
    [self creatView];
    [self creatView2];
    
}

- (void)creatView{
    _topView = [RewardTopView new];
    [self.scrollView addSubview:_topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 46));
        make.right.left.mas_equalTo(self.scrollView);
    }];
    
    /*
    _view1 = [RewardSelectImageView new];
    _view1.infoLabel.text = @"请确保申请书照片清晰完整";
    [self.scrollView addSubview:_view1];
    
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        make.right.left.mas_equalTo(self.scrollView);
    }];
    
    _view2 = [RewardSelectImageView new];
    _view2.infoLabel.text = @"请确保能看清人像和申请书内容";
    [self.scrollView addSubview:_view2];
    
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view1.mas_bottom).offset(10);
        make.right.left.mas_equalTo(self.scrollView);
    }];
     */
    
}

- (void)creatView2{
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"提交" textColor:LZWhiteColor];
    [self.scrollView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(30);
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
    }];
    [btn setDefaultGradientWithCornerRadius:6];
    
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLab = [UILabel labelWithFontSize:12 textColor:UIColorHex(0x3A3A3A)];
    
    [self.scrollView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(btn.mas_centerX).offset(10);
        make.top.mas_equalTo(btn.mas_bottom).offset(15);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *btnAgree = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAgree setImage:UIImageName(@"reward_bugouxuan") forState:UIControlStateNormal];
    [btnAgree setImage:UIImageName(@"reward_gouxuan") forState:UIControlStateSelected];
    btnAgree.selected = YES;
    [self.scrollView addSubview:btnAgree];
    _btnAgree = btnAgree;
    
    [btnAgree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.mas_equalTo(titleLab.mas_left).offset(-3);
    }];
    
    [btnAgree addTouchAction:^(UIButton *sender) {
        sender.selected = !sender.isSelected;
    }];
    
    
    //协议
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"同意<悬赏协议>及其服务条款"];
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(33,33,33) range:NSMakeRange(0, attributedString.length)];
    
        // text-style1
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(2, 6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(71,104,243) range:NSMakeRange(2, 6)];
    
    titleLab.attributedText = attributedString;
    
    UIButton *btnAgree1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.scrollView addSubview:btnAgree1];
    
    [btnAgree1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLab);
        make.size.mas_equalTo(CGSizeMake(40, 15));
        make.left.mas_equalTo(titleLab.mas_left).offset(25);
    }];
    
    @weakify(self);
    [btnAgree1 addTouchAction:^(UIButton *sender) {
        @strongify(self);
        H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithUrl:@"http://pay.6wang666.com/userAgreement/releaseform.html"];
        h5.title = @"悬赏协议";
        PushController(h5);
    }];
}


- (void)submit{

    if (!self.btnAgree.isSelected) {
        [self showMessage:@"请先同意用户协议及服务条款！"];
        return ;
    }
    
    if (!self.topView.textF.text.length) {
        [self showMessage:@"请输入内容！"];
        return ;
    }
    
    if (!self.topView.textF.text.integerValue) {
        [self showMessage:@"费率不能为0！"];
        return ;
    }
    
    /*
    if (!self.view1.image) {
        [self showMessage:@"请上传授权书照片！"];
        return ;
    }
    
    if (!self.view2.image) {
        [self showMessage:@"请上传本人手持授权书照片！"];
        return ;
    }
     */
    
    NSInteger vaule = self.topView.textF.text.integerValue*100;

    [RewardViewModel submitChangeRewardWithValue:@(vaule).stringValue image1:nil image2:nil block:^(BOOL success) {
        if (success) {
            [self showMessage:@"提交成功!"];
            [self lz_popController];
        }
    }];
}

@end
