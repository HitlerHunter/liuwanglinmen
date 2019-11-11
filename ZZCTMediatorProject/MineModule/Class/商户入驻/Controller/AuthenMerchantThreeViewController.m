//
//  AuthenMerchantThreeViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantThreeViewController.h"
#import "AuthenMerchantTopView.h"
#import "AuthenMerchantPhotoView.h"
#import "AuthenMerchantStatusController.h"

typedef NS_ENUM(NSUInteger, AuthenMerchantType) {
    AuthenMerchantTypePerson,//个体只能对私
    AuthenMerchantTypeCompanySi,//企业对私
    AuthenMerchantTypeCompanyGong,//企业对公
};

@interface AuthenMerchantThreeViewController ()

@property (nonatomic, strong) LZUserMerchant *merchant;
@property (nonatomic, strong) AuthenMerchantTopView *topView;
@property (nonatomic, strong) AuthenMerchantPhotoView *photoView1;
@property (nonatomic, strong) AuthenMerchantPhotoView *photoView2;
@property (nonatomic, strong) AuthenMerchantPhotoView *photoView3;

@property (nonatomic, assign) AuthenMerchantType merchantType;

@end

@implementation AuthenMerchantThreeViewController

- (instancetype)initWithMerchant:(LZUserMerchant *)merchant{
    self = [super init];
    if (self) {
        self.merchant = merchant;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户录入";
    [self.view addSubview:self.scrollView];
    
    AuthenMerchantTopView *topView = [[AuthenMerchantTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    topView.step = 3;
    [self.scrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(70);
        make.width.mas_equalTo(kScreenWidth);
    }];
    _topView = topView;
    
    NSString *merchantType = self.merchant.pmsMerchantInfo.pnrpayMerType;
    NSString *balanceUserFlag = self.merchant.pmsMerchantSettlement.balanceUserFlag;
    if (merchantType.intValue == 5) {
        _merchantType = AuthenMerchantTypePerson;
    }else if(balanceUserFlag.intValue == 1){
        _merchantType = AuthenMerchantTypeCompanySi;
    }else if(balanceUserFlag.intValue == 2){
        _merchantType = AuthenMerchantTypeCompanyGong;
    }
    
    [self creatPhoto1];
    
    UIButton *btn = [UIButton buttonWithFontSize:18 text:@"完成" textColor:LZWhiteColor];
    [self.scrollView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-30);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.photoView3.mas_bottom).offset(30 );
    }];
    
    [btn setDefaultGradientWithCornerRadius:4];
    
    @weakify(self);
    [btn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [self submit];
    }];
    
}

- (void)creatPhoto1{
    AuthenMerchantPhotoModel *model1 = [AuthenMerchantPhotoModel new];
    model1.bgImageName = @"shenfenzhengzhengmian";
    model1.title = @"身份证正面";
    model1.imageUrl = self.merchant.pmsMerchantPicture.idCardFront;
    
    AuthenMerchantPhotoModel *model2 = [AuthenMerchantPhotoModel new];
    model2.bgImageName = @"shenfenzhengfanmian";
    model2.title = @"身份证背面";
    model2.imageUrl = self.merchant.pmsMerchantPicture.idCardBack;
    
    AuthenMerchantPhotoModel *model3 = [AuthenMerchantPhotoModel new];
    model3.bgImageName = @"shouchi";
    model3.title = @"手持身份证正面照";
    model3.imageUrl = self.merchant.pmsMerchantPicture.idcardinhand;
    
    AuthenMerchantPhotoModel *model4 = [AuthenMerchantPhotoModel new];
    model4.bgImageName = @"yingyezhizhao";
    model4.title = @"营业执照";
    model4.imageUrl = self.merchant.pmsMerchantPicture.licensePhoto;
    
    AuthenMerchantPhotoModel *model5 = [AuthenMerchantPhotoModel new];
    model5.bgImageName = @"kaihuxukezheng";
    model5.title = @"银行开户许可证";
    model5.imageUrl = self.merchant.pmsMerchantPicture.openLicense;
    
    AuthenMerchantPhotoModel *model6 = [AuthenMerchantPhotoModel new];
    model6.bgImageName = @"yinhangka";
    model6.title = @"银行卡正面";
    model6.imageUrl = self.merchant.pmsMerchantPicture.authbankcardfront;
    
    AuthenMerchantPhotoModel *model7 = [AuthenMerchantPhotoModel new];
    model7.bgImageName = @"mentouzhao";
    model7.title = @"门头照";
    model7.imageUrl = self.merchant.pmsMerchantPicture.shopPhoto;
    
    AuthenMerchantPhotoModel *model8 = [AuthenMerchantPhotoModel new];
    model8.bgImageName = @"mendianneijing";
    model8.title = @"门店内景照";
    model8.imageUrl = self.merchant.pmsMerchantPicture.goodsPhoto;
    
    NSArray *arrAll = @[model1,model2,model3,model4,model5,model6,model7,model8];
    for (AuthenMerchantPhotoModel *model in arrAll) {
        model.canEdit = self.merchant.canEdit;
    }
    
    _photoView1 = [[AuthenMerchantPhotoView alloc] init];
    _photoView2 = [[AuthenMerchantPhotoView alloc] init];
    _photoView3 = [[AuthenMerchantPhotoView alloc] init];
    
    _photoView1.title = @"法定代表人证照";
    _photoView2.title = @"企业证照";
    _photoView3.title = @"门店信息";
    
    if (_merchantType == AuthenMerchantTypePerson) {
        _photoView1.title = @"结算人证照";
        
        model1.imageUrl = self.merchant.pmsMerchantPicture.authCardFront;
        model2.imageUrl = self.merchant.pmsMerchantPicture.authCardBack;
        
        _photoView1.dataArray = @[model1,model2];
        
        _photoView2.dataArray = @[model4,model6];
        _photoView3.dataArray = @[model7,model8];
        
    }else if (_merchantType == AuthenMerchantTypeCompanyGong) {
        _photoView1.title = @"法定代表人证照";
        _photoView1.dataArray = @[model1,model2];
        
        _photoView2.dataArray = @[model4,model5];
        _photoView3.dataArray = @[model7,model8];
    }else if (_merchantType == AuthenMerchantTypeCompanySi) {
        _photoView1.title = @"法定代表人证照";
        _photoView1.dataArray = @[model1,model2,model3];
        
        _photoView2.dataArray = @[model4,model6];
        _photoView3.dataArray = @[model7,model8];
    }
    
    
    [self.scrollView addSubview:_photoView1];
    [_photoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    
    [self.scrollView addSubview:_photoView2];
    [_photoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoView1.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    
    [self.scrollView addSubview:_photoView3];
    [_photoView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoView2.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    
}


- (void)submit{
    
    if (!self.merchant.canEdit) {
        [self lineBackWithId:LinearBackId_AuthenLine];
        return;
    }
    
    NSArray <AuthenMerchantPhotoModel *> *dataArray1 = _photoView1.dataArray;
    NSArray <AuthenMerchantPhotoModel *> *dataArray2 = _photoView2.dataArray;
    NSArray <AuthenMerchantPhotoModel *> *dataArray3 = _photoView3.dataArray;
    
    for (AuthenMerchantPhotoModel *photo in dataArray1) {
        if (photo.imageUrl.length == 0) {
            [self showMessage:[NSString stringWithFormat:@"请上传%@",photo.title]];
            return;
        }
    }
    
    if (_merchantType == AuthenMerchantTypePerson) {
        self.merchant.pmsMerchantPicture.authCardFront = [dataArray1 objectAtIndex:0].imageUrl;
        self.merchant.pmsMerchantPicture.authCardBack = [dataArray1 objectAtIndex:1].imageUrl;
    }else{
        self.merchant.pmsMerchantPicture.idCardFront = [dataArray1 objectAtIndex:0].imageUrl;
        self.merchant.pmsMerchantPicture.idCardBack = [dataArray1 objectAtIndex:1].imageUrl;
        self.merchant.pmsMerchantPicture.idcardinhand = [[dataArray1 safeObjectWithIndex:2] imageUrl];
    }
    
    
    for (AuthenMerchantPhotoModel *photo in dataArray2) {
        if (photo.imageUrl.length == 0) {
            [self showMessage:[NSString stringWithFormat:@"请上传%@",photo.title]];
            return;
        }
    }
    
    self.merchant.pmsMerchantPicture.licensePhoto = [dataArray2 objectAtIndex:0].imageUrl;
    
    if (_merchantType == AuthenMerchantTypePerson) {
       self.merchant.pmsMerchantPicture.authbankcardfront = [dataArray2 objectAtIndex:1].imageUrl;
        
    }else if (_merchantType == AuthenMerchantTypeCompanyGong) {
        self.merchant.pmsMerchantPicture.openLicense = [dataArray2 objectAtIndex:1].imageUrl;
    }else if (_merchantType == AuthenMerchantTypeCompanySi) {
       self.merchant.pmsMerchantPicture.authbankcardfront = [dataArray2 objectAtIndex:1].imageUrl;
    }
    
    for (AuthenMerchantPhotoModel *photo in dataArray3) {
        if (photo.imageUrl.length == 0) {
            [self showMessage:[NSString stringWithFormat:@"请上传%@",photo.title]];
            return;
        }
    }
    
    self.merchant.pmsMerchantPicture.shopPhoto = [dataArray3 objectAtIndex:0].imageUrl;
    self.merchant.pmsMerchantPicture.goodsPhoto = [dataArray3 objectAtIndex:1].imageUrl;
    
    self.merchant.pmsMerchantInfo.tellerId = CurrentUser.mobile;
    self.merchant.pmsMerchantInfo.linkmanName = self.merchant.pmsMerchantInfo.corporationName;
    self.merchant.pmsMerchantInfo.linkmanIdCard = self.merchant.pmsMerchantInfo.corporationIdcard;
    self.merchant.pmsMerchantInfo.linkmanMobile = CurrentUser.mobile;
    self.merchant.pmsMerchantInfo.isCreditCode = @"1";
    self.merchant.pmsMerchantInfo.salesMan = CurrentUser.usrName;
    self.merchant.pmsMerchantInfo.createName = CurrentUser.usrName;
    self.merchant.pmsMerchantInfo.createNo = CurrentUser.usrNo;
    self.merchant.pmsMerchantInfo.userNo = CurrentUser.usrNo;
    
    NSDictionary *merchantJson = [self.merchant mj_JSONObject];
    
    SDLog(@"merchantJson : \n%@",merchantJson);
    NSString *key = [NSString stringWithFormat:@"%@_merchantJson",CurrentUser.usrNo];
    [[NSUserDefaults standardUserDefaults] setObject:merchantJson forKey:key];
    
    NSInteger statu = self.merchant.pmsMerchantInfo.status.integerValue;
    if (statu == -1) {
        //新增
        [self submitWithUrl:@"/merchant-biz/pmsMerchantInfo/EnterpriseBusinessInput" params:merchantJson];
    }else if(statu != 0 && statu != 5){
        //修改
        [self submitWithUrl:@"/merchant-biz/pmsMerchantInfo/updateMerchantAll" params:merchantJson];
    }
}

- (void)submitWithUrl:(NSString *)url params:(NSDictionary *)params{
    
    ZZNetWorker.POST.zz_url(url).zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            [self showMessage:@"操作成功!"];
            
            if (self.merchant.pmsMerchantInfo.status_lz == AuthenMerchantStatusNoSubmit) {
                
                AuthenMerchantStatusController *statusVC = [[AuthenMerchantStatusController alloc] initWithMerchant:self.merchant];
                [self.navigationController pushViewController:statusVC animated:YES linearBackId:LinearBackId_AuthenLine];
            }else{
                [self lineBackWithId:LinearBackId_AuthenLine];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

@end
