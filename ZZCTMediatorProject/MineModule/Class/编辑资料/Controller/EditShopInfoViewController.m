//
//  EditShopInfoViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditShopInfoViewController.h"
#import "EditTitleTextCell.h"
#import "EditTitleAddressCell.h"
#import "EditWorkTimeCell.h"
#import "EditShopLogoCell.h"
#import "EditBgImageSelectCell.h"
#import "EditTagsCell.h"
#import "EditShopMessageCell.h"
#import "EditShopModel.h"

#import "EditMapViewController.h"
#import "SelectStoreViewController.h"
#import "ChangeUserNameViewController.h"
#import "ZZCLGeocoder.h"
#import "CTMediator+ModuleMineActions.h"
#import "EditCertificateViewController.h"
#import "EditShopViewModel.h"
#import "EditPhotoModel.h"

@interface EditShopInfoViewController ()
@property (nonatomic, strong) EditShopModel *model;

//编辑 本地图片
@property (nonatomic, strong) UIImage *logo;
@property (nonatomic, strong) NSArray *bgImageArray;
@property (nonatomic, strong) UIImage *zzImage;

@property (nonatomic, strong) EditTagsCell *tagsCell;
@property (nonatomic, strong) EditShopMessageCell *shopMessageCell;
@property (nonatomic, strong) EditBgImageSelectCell *bgImageCell;
@end

@implementation EditShopInfoViewController

- (instancetype)initWithShopModel:(EditShopModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (EditShopModel *)model{
    if (!_model) {
        _model = [EditShopModel new];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑资料";
    
    [self.view addSubview:self.scrollView];
    self.scrollView.height -= 44;
    
    UIButton *saveBtn = [UIButton buttonWithFontSize:16 text:@"保存" textColor:LZWhiteColor];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view);
    }];
    [saveBtn setDefaultGradient];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    @weakify(self);
    
    EditTitleTextCell *shopNameCell = [EditTitleTextCell new];
    shopNameCell.title = @"店铺名称";
    shopNameCell.hiddenIcon = YES;
    [self.scrollView addSubview:shopNameCell];
    [shopNameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(46);
        make.top.mas_equalTo(10);
    }];
    
    shopNameCell.text = self.model.shopName;
    [RACObserve(self.model, shopName) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        shopNameCell.text = self.model.shopName;
    }];
    //修改店铺名称
    shopNameCell.tapBlock = ^{
        @strongify(self);
        ChangeUserNameViewController *vc = [[ChangeUserNameViewController alloc] init];
        vc.title = @"店铺名称";
        vc.text = self.model.shopName;
        vc.finishBlock = ^(NSString * _Nullable obj) {
            self.model.shopName = obj;
        };
        PushController(vc);
    };
    
    EditTitleTextCell *workingAreaCell = [EditTitleTextCell new];
    workingAreaCell.title = @"经营地区";
    [workingAreaCell addBottomLine];
    [workingAreaCell setBottomLineX:15];
    workingAreaCell.hiddenIcon = YES;
    [self.scrollView addSubview:workingAreaCell];
    [workingAreaCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(shopNameCell.mas_bottom).offset(10);
    }];
    
    workingAreaCell.text = self.model.shopProvinceCityArea;
    
    EditTitleTextCell *cardAddressCell = [EditTitleTextCell new];
    cardAddressCell.title = @"执照地址";
    [cardAddressCell addBottomLine];
    [cardAddressCell setBottomLineX:15];
    cardAddressCell.hiddenIcon = YES;
    [self.scrollView addSubview:cardAddressCell];
    [cardAddressCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(workingAreaCell.mas_bottom);
    }];
    
    cardAddressCell.text = CurrentUserMerchant.pmsMerchantInfo.address;
    
    EditTitleAddressCell *workAddressCell = [EditTitleAddressCell new];
    workAddressCell.title = @"经营地址";
    [workAddressCell addBottomLine];
    [workAddressCell setBottomLineX:15];
    [self.scrollView addSubview:workAddressCell];
    [workAddressCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(cardAddressCell.mas_bottom);
    }];
    
    workAddressCell.tapBlock = ^{
        @strongify(self);//定位
        EditMapViewController *mapVC = [[EditMapViewController alloc] initWithLatitude:self.model.latitude longitude:self.model.longitude FinishBlock:^(NSDictionary * _Nonnull addressDic) {
            self.model.shopProvince = addressDic[ZZLocationStateKey];
            self.model.shopCity = addressDic[ZZLocationCityKey];
            self.model.shopArea = addressDic[ZZLocationDistrictKey];
            self.model.shopAddress = addressDic[ZZLocationStreetNameKey];
            
            self.model.latitude = addressDic[ZZLocationLatitudeKey];
            self.model.longitude = addressDic[ZZLocationLongitudeKey];
        }];
        PushController(mapVC);
    };
    //经营地区、经营地址
    [RACObserve(self.model, shopAddress) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        workAddressCell.text = self.model.shopAddress;
        workingAreaCell.text = self.model.shopProvinceCityArea;
    }];
    
    //联系方式
    EditTitleTextCell *phoneCell = [EditTitleTextCell new];
    phoneCell.title = @"联系方式";
    phoneCell.hiddenIcon = YES;
    [self.scrollView addSubview:phoneCell];
    [phoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(46);
        make.top.mas_equalTo(workAddressCell.mas_bottom);
    }];
    
    phoneCell.text = self.model.shopMobile;
    [RACObserve(self.model, shopMobile) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        phoneCell.text = self.model.shopMobile;
    }];
    //联系方式
    phoneCell.tapBlock = ^{
        @strongify(self);
        ChangeUserNameViewController *vc = [[ChangeUserNameViewController alloc] init];
        vc.title = @"联系方式";
        vc.text = self.model.shopMobile;
        vc.finishBlock = ^(NSString * _Nullable obj) {
            self.model.shopMobile = obj;
        };
        PushController(vc);
    };
    
    //经营分类
    EditTitleTextCell *workTypeCell = [EditTitleTextCell new];
    workTypeCell.title = @"经营分类";
    [self.scrollView addSubview:workTypeCell];
    [workTypeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(phoneCell.mas_bottom).offset(10);
    }];
    
    workTypeCell.text = self.model.shopType;
    //经营分类
    [RACObserve(self.model, shopType) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        workTypeCell.text = self.model.shopType;
    }];
    workTypeCell.tapBlock = ^{
        @strongify(self);//定位
       UIViewController *vc = [[CTMediator sharedInstance] CTMediator_SelectStoreWithDataArray:@[@"美食",@"娱乐休闲",@"生活",@"住宿",] block:^(NSInteger index, NSString *storeName) {
           self.model.shopType = storeName;
        }];

        [self presentViewController:vc animated:YES completion:nil];
    };
    
    EditWorkTimeCell *workTimeCell = [EditWorkTimeCell new];
    workTimeCell.title = @"经营时间";
    [self.scrollView addSubview:workTimeCell];
    [workTimeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(workTypeCell.mas_bottom).offset(10);
    }];
    [workTimeCell setStart:self.model.startTime End:self.model.endTime];
    
    [RACObserve(workTimeCell, start) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.model.startTime = x;
    }];
    
    [RACObserve(workTimeCell, end) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.model.endTime = x;
    }];
    
    
    EditShopLogoCell *shopLogoCell = [EditShopLogoCell new];
    shopLogoCell.title = @"店铺logo";
    shopLogoCell.text = @"待上传";
    [shopLogoCell addBottomLine];
    [shopLogoCell setBottomLineX:15];
    [self.scrollView addSubview:shopLogoCell];
    [shopLogoCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(workTimeCell.mas_bottom).offset(10);
    }];
    //logo
    if (self.model.shopLog.length) {
        shopLogoCell.logoUrl = self.model.shopLog;
    }
    shopLogoCell.didUploadLogoBlock = ^(NSString * _Nonnull url) {
        @strongify(self);
        self.model.shopLog = url;
    };
    
    EditBgImageSelectCell *bgImageCell = [EditBgImageSelectCell new];
    [bgImageCell addBottomLine];
    [bgImageCell setBottomLineX:15];
    [self.scrollView addSubview:bgImageCell];
    [bgImageCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(shopLogoCell.mas_bottom);
        make.height.mas_greaterThanOrEqualTo(130);
    }];
    _bgImageCell = bgImageCell;
    bgImageCell.imageArray = self.model.tbStorePic;
    
    EditTitleTextCell *shopZZCell = [EditTitleTextCell new];
    shopZZCell.title = @"店铺资质";
    [self.scrollView addSubview:shopZZCell];
    [shopZZCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(bgImageCell.mas_bottom);
    }];
    
    if (self.model.hasCertificate) {
        shopZZCell.text = @"点击查看";
    }
    shopZZCell.tapBlock = ^{
        @strongify(self);
        EditCertificateViewController *cer = [[EditCertificateViewController alloc] initWithPhotoModel:self.model.certificateModel];
        cer.finishBlock = ^(EditPhotoModel * _Nonnull photoModel) {
            [self.model addCertificate:photoModel];
        };
        PushController(cer);
    };
    
    EditTagsCell *tagsCell = [EditTagsCell new];
    [tagsCell addBottomLine];
    [tagsCell setBottomLineX:15];
    [self.scrollView addSubview:tagsCell];
    [tagsCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(shopNameCell);
        make.top.mas_equalTo(shopZZCell.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    _tagsCell = tagsCell;
    [tagsCell setMineDataArray:self.model.tbShopStruct];
    
    EditShopMessageCell *shopMessageCell = [EditShopMessageCell new];
    [self.scrollView addSubview:shopMessageCell];
    [shopMessageCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(shopNameCell);
        make.height.mas_equalTo(173);
        make.top.mas_equalTo(tagsCell.mas_bottom);
        make.bottom.mas_equalTo(-10);
    }];
    _shopMessageCell = shopMessageCell;
    shopMessageCell.text = self.model.shopDesc;
    
}

- (void)save{
    self.model.tbShopStruct = [_tagsCell getSelectedTags];
    self.model.shopDesc = _shopMessageCell.text;
    
    //经营分类必填
    if (self.model.shopType.length == 0) {
        [self showMessage:@"请选择经营分类!"];
        return;
    }
    
    //表情检测
    if (self.model.shopDesc.hasEmoji) {
        [SVProgressHUD showInfoWithStatus:@"店铺描述不能含有表情或非法字符!"];
        return;
    }
    
    [self uploadBgImages];
}

- (void)uploadBgImages{
    NSArray <EditPhotoModel *> *bgArray = _bgImageCell.imageArray;
    
    if (bgArray.count == 0) {
        [self showMessage:@"请选择店铺背景图！"];
        return;
    }
    
    NSMutableArray *fileArray = [NSMutableArray array];
    [bgArray enumerateObjectsUsingBlock:^(EditPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.image && obj.url.length==0) {
            
            NSData *imageData1 = UIImageJPEGRepresentation(obj.image, 0.8);
            UpLoadFileModel *file1 = [UpLoadFileModel new];
            file1.dataFromWay = OSSUpLoadDataFromWayData;
            file1.fileData = imageData1;
            file1.UpLoadType = OSSUpLoadDataTypeFile;
            file1.coustomIndex = idx;
            file1.fileName = @"png".randomStrForURL;
            [fileArray addObject:file1];
        }
    }];
    
    if (fileArray.count) {
        [[OssService service] asyncPutFiles:fileArray oneCompletion:^(int index, UpLoadFileModel *backModel) {
            EditPhotoModel *photoModel = bgArray[backModel.coustomIndex];
            photoModel.url = backModel.fileName;
            SDLog(@"imageUrl_%d : \n%@",index,backModel.fileName);
        } allCompletion:^{
            [SVProgressHUD dismiss];
            
            self.model.tbStorePic = bgArray;
            [self.model addCertificate:self.model.certificateModel];
            
            [self submitEdit];
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"上传图片失败！"];
        }];
    }else{
        //做了删除背景图操作 需要替换原数据
        self.model.tbStorePic = bgArray;
        [self.model addCertificate:self.model.certificateModel];
        [self submitEdit];
    }
    
    
}

- (void)submitEdit{
    
    if (self.model.editType == EditShopTypeAdd) {
        //添加
        [EditShopViewModel creatShopInfoWithShopModel:self.model Block:^(BOOL success) {
            if (success) {
                [self lz_popController];
            }
        }];
        return;
    }
    
    //修改
    [EditShopViewModel editShopInfoWithShopModel:self.model Block:^(BOOL success) {
        if (success) {
            [self lz_popController];
        }
    }];
}

@end
