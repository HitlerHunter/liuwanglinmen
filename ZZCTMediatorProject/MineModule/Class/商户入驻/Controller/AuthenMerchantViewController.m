//
//  AuthenMerchantViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantViewController.h"
#import "SYHomeTypeView.h"
#import "AuthenMerchantOneViewController.h"
#import "AuthenMerchantInfoViewController.h"
#import "AuthenMerchantStatusController.h"

@interface AuthenMerchantViewController ()<SYHomeTypeViewDelegate>
@property (nonatomic, strong) SYHomeTypeView *typeScrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LZUserMerchant *merchant;
@end

@implementation AuthenMerchantViewController

+ (void)showAuthenMerchantWithViewController:(UIViewController *)superController{
    
    [[UserManager shareInstance] getUserMerchant:^(LZUserMerchant *merchant) {
//        merchant.pmsMerchantInfo.status = @"0";
        if (merchant.pmsMerchantInfo.status_lz == AuthenMerchantStatusSuccess) {
            
            //成功状态 查看info
            AuthenMerchantInfoViewController *info = [[AuthenMerchantInfoViewController alloc] initWithMerchant:merchant];
            [superController.navigationController pushViewController:info animated:YES linearBackId:LinearBackId_AuthenLine];
            
        }else if(merchant.pmsMerchantInfo.status_lz ==  AuthenMerchantStatusNoSubmit){
            //未提交过状态 提交
            AuthenMerchantViewController *vc = [AuthenMerchantViewController new];
            vc.merchant = merchant;
            if (superController.navigationController) {
                [superController.navigationController pushViewController:vc animated:YES linearBackId:LinearBackId_AuthenLine];
            }
        }else{
            AuthenMerchantStatusController *statusVC = [[AuthenMerchantStatusController alloc] initWithMerchant:merchant];
            [superController.navigationController pushViewController:statusVC animated:YES linearBackId:LinearBackId_AuthenLine];
        }
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户入驻";
    
    [self.view addSubview:self.scrollView];
    
    NSArray *imageArray = @[@"主题",@"平台介绍",@"案例",@"流程",@"问题",];
    
    UIView *lastView = nil;
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [UIImageView viewWithImage:UIImageName(imageArray[i])];
        [self.scrollView addSubview:imageView];
        
        if (i == 0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.width.mas_equalTo(kScreenWidth);
            }];
        }else if (i == 1){
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(9);
                make.right.mas_equalTo(-9);
                make.top.mas_equalTo(lastView.mas_bottom).offset(-70);
            }];
        }else if (i == imageArray.count-1){
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(lastView);
                make.top.mas_equalTo(lastView.mas_bottom).offset(10);
                make.bottom.mas_equalTo(-60);
            }];
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(lastView);
                make.top.mas_equalTo(lastView.mas_bottom).offset(10);
            }];
        }
        
        lastView = imageView;
    }
    

    [self.view addSubview:self.typeScrollView];
    [self.typeScrollView initWithTitleArray:@[@"平台介绍",@"优秀案例",@"开店流程",@"常见问题"]];
    
    UIButton *btn = [UIButton buttonWithFontSize:18 text:@"立即认证" textColor:LZWhiteColor];
    [self.scrollView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    [btn setDefaultGradientWithCornerRadius:4];
    
    @weakify(self);
    [btn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        AuthenMerchantOneViewController *one = [[AuthenMerchantOneViewController alloc] initWithMerchant:self.merchant];
        PushIdController(one, LinearBackId_AuthenLine);
    }];
    
}

    //type回调
- (void)view:(SYHomeTypeView *)view clickBtnAtIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(0, (self.scrollView.contentSize.height/4)*index) animated:YES];
};

- (SYHomeTypeView *)typeScrollView{
    if (!_typeScrollView) {
        _typeScrollView = [[SYHomeTypeView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, 40) maker:^(SYHomeTypeMaker * _Nonnull maker) {
            maker.titleColorNormal = LZWhiteColor;
            maker.titleColorSelected = LZWhiteColor;
            maker.lineWScale = 0.5;
            maker.titleSelectedScale = 1.1;
            maker.spaceX = 0;
            maker.firstItemSpaceX = maker.spaceX;
            maker.lineEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
            maker.minItemW = kScreenWidth/4;
        }];
        _typeScrollView.delegate = self;
        _typeScrollView.backgroundColor = rgba(39,10,12,0.5);
    }
    return _typeScrollView;
}
@end
