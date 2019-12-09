//
//  GoodsDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsDetailTopView.h"
#import "GoodsDetailToolView.h"
#import "GoodsSureOrderController.h"
#import "GoodsModel.h"
#import <SDImageCache.h>

@interface GoodsDetailViewController ()

@property (nonatomic, strong) GoodsDetailTopView *topView;
@property (nonatomic, strong) GoodsDetailToolView *bottomView;
@property (nonatomic, strong) GoodsModel *model;
@property (nonatomic, strong) NSString *type;

@end

@implementation GoodsDetailViewController

- (instancetype)initWithType:(NSString *)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    [self requestData];
    
    _bottomView = [[GoodsDetailToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 56)];
    _bottomView.backgroundColor = LZWhiteColor;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(56);
    }];
    
    @weakify(self);
    _bottomView.buyBlock = ^{
        @strongify(self);
        GoodsSureOrderController *vc = [[GoodsSureOrderController alloc] initWithGoodsModel:self.model];
        PushController(vc);
    };
    //GoodsDetail_share
    [self addRightItemWithImage:@"GoodsDetail_share" title:nil font:nil color:nil block:^{
        @strongify(self);
       id image = [[SDImageCache sharedImageCache] imageFromCacheForKey:self.model.topArray.firstObject];
        [AppCenter shareURL:@"http://admin.6wang666.com/new6wH5/html/goodsDetails.html" title:@"帮助他财大器粗，这是让他一辈子对你死心塌地的不二法门" subTitle:@"男儿“裆”自强" image:image];
    }];
}

- (void)creatUI{
    self.scrollView.height -= 56;
    [self.view addSubview:self.scrollView];
    _topView = [[GoodsDetailTopView alloc] initWithGoodsModel:_model];
    [self.scrollView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(self.topView.height);
        make.left.right.top.mas_equalTo(0);
    }];
    
    UIView *lastView = _topView;
    for (int i = 0; i < _model.bottomArray.count; i++) {
        UIImageView *imageView = [UIImageView new];
        [self.scrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lastView.mas_bottom);
        }];
        
        @weakify(imageView);
        [imageView sd_setImageWithURL:TLURL(_model.bottomArray[i])completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            @strongify(imageView);
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(image.size.height*(kScreenWidth/image.size.width));
            }];
        }];
        
        lastView = imageView;
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
    }];
}

- (void)requestData{

    NSString *url = [NSString stringWithFormat:@"/outside-biz/dict/type/%@",_type];
    ZZNetWorker.GET.zz_param(@{})
    .zz_url(url)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            NSArray *arr = model_net.data;
            if (arr.count) {
                NSDictionary *dic = arr.firstObject;
                NSString *str = dic[@"remarks"];
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSString *topPic = json[@"topPic"];
                NSArray *topPicArray = [topPic componentsSeparatedByString:@","];
                
                NSString *buttomPic = json[@"buttomPic"];
                NSArray *buttomPicArray = [buttomPic componentsSeparatedByString:@","];
                self.model = [GoodsModel mj_objectWithKeyValues:json];
                if (topPicArray.count) {
                    self.model.logo = topPicArray.firstObject;
                }
                self.model.topArray = topPicArray;
                self.model.bottomArray = buttomPicArray;
                
                [self creatUI];
            }
            
        }else{
            [self showMessage:model_net.message];
        }
    });
}



@end
