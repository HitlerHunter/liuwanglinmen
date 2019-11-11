//
//  SKMViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/15.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SKMViewController.h"
#import "SKMCardView.h"
#import "SKMTopMenuView.h"

@interface SKMViewController ()

@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) SKMCardView *cardView;
@property (nonatomic, strong) SKMTopMenuView *menuView;

@property (nonatomic, strong) NSString *url_aliPay;
@property (nonatomic, strong) NSString *url_wechatPay;


@end


@implementation SKMViewController

- (NSString *)backIconName{
    return @"back_white";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//- (BOOL)willAddBackButton{
//    return YES;
//}

- (instancetype)initWithMoney:(NSString *)money remark:(NSString *)remark{
    self = [super init];
    if (self) {
        _money = money;
        _remark = remark;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"二维码收款";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.backgroundColor = rgb(248,248,248);
    
    UIView *topColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 114+LZApp.shareInstance.app_navigationBarHeight)];
    [topColorView setDefaultGradient];
    
    [self.scrollView addSubview:topColorView];
    
    CGFloat scale = (kScreenWidth-50)/335.0;
    
    _cardView = [[SKMCardView alloc] initWithFrame:CGRectMake(25, 117-64+LZApp.shareInstance.app_navigationBarHeight, kScreenWidth-50, 400*scale)];
    _cardView.backgroundColor = LZWhiteColor;
    _cardView.lz_setView.lz_shadow(1, rgba(0, 0, 0, 0.1), CGSizeMake(0, 2.5), 1, 7.5);
    [self.scrollView addSubview:_cardView];
    
    _cardView.money = self.money;
    
    _menuView = [[SKMTopMenuView alloc] initWithFrame:CGRectMake(self.cardView.x, self.cardView.top-50, self.cardView.width, 40)];
    [self.scrollView addSubview:_menuView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, self.cardView.bottom+30, self.cardView.width, 45);
    backBtn.centerX = self.cardView.centerX;
    
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [backBtn setTitle:@"切换到扫一扫" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setDefaultGradientWithCornerRadius:6];
    
    [self.scrollView addSubview:backBtn];
    self.scrollView.contentSize = CGSizeMake(0, backBtn.bottom+30);
    
    @weakify(self);
    _menuView.btnClickBlock = ^(NSInteger index) {
        @strongify(self);
        if (index == 0) {
            [self getCodeUrlWithType:WechatName];
        }else{
            [self getCodeUrlWithType:AlipayName];
        }
    };
    
    [backBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self getCodeUrlWithType:WechatName];
}

static NSString *AlipayName = @"A1";
static NSString *WechatName = @"W1";

- (void)getCodeUrlWithType:(NSString *)type{
    
    if ([type isEqualToString:WechatName]) {
        if(_url_wechatPay.length){
            [self creatWechatUrl];
            return;
        }
    }else if ([type isEqualToString:AlipayName]) {
        if(_url_aliPay.length){
            [self creatAlipayUrl];
            return;
        }
    }
    
    NewParams;
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    [params setSafeObject:GOODS_Name_Alipay forKey:@"goods_name"];
    [params setSafeObject:self.money forKey:@"orderAmt"];
    [params setSafeObject:type forKey:@"payType"];
    [params setSafeObject:self.remark forKey:@"remark"];
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_param(params).zz_url(@"/pay/huifuPay/shaoMaPay")
    .zz_isPostByURLSession(YES).zz_setParamType(ZZNetWorkerParamTypeAppendAfterURL)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            
            if ([type isEqualToString:WechatName]) {
                self.url_wechatPay = model_net.data;
                [self creatWechatUrl];
            }else if ([type isEqualToString:AlipayName]) {
                self.url_aliPay = model_net.data;
                [self creatAlipayUrl];
            }
        }
    });
}

- (void)creatAlipayUrl{
   UIImage *image = [ZZCodeTool qrCodeImageWithContent:_url_aliPay codeImageSize:300 logo:[AppCenter appIcon] logoFrame:CGRectZero red:0 green:0 blue:0];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = .5f;
        // 使用@"suck"动画, 该动画与动画方向无关
    transition.type = @"fade";//rippleEffect 私有ipa
    [self.cardView.imageView.layer addAnimation:transition forKey:@"animation"];
    
    self.cardView.imageView.image = image;
    self.cardView.info = @"支付宝扫一扫，向我付钱";
}

- (void)creatWechatUrl{
    UIImage *image = [ZZCodeTool qrCodeImageWithContent:_url_wechatPay codeImageSize:300 logo:[AppCenter appIcon] logoFrame:CGRectZero red:0 green:0 blue:0];
    
    CATransition *transition = [CATransition animation];
    transition.duration = .5f;
        // 使用@"suck"动画, 该动画与动画方向无关
    transition.type = @"fade";//rippleEffect 私有ipa
    [self.cardView.imageView.layer addAnimation:transition forKey:@"animation"];
    
    self.cardView.imageView.image = image;
    self.cardView.info = @"微信扫一扫，向我付钱";
}

#pragma mark - 导航栏透明
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
        //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
        //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

@end
