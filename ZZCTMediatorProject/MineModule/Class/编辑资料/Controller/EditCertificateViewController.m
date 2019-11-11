//
//  EditCertificateViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/4.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditCertificateViewController.h"
#import "EditPhotoModel.h"
#import "ZLOnePhoto.h"

@interface EditCertificateViewController ()

@property (nonatomic, strong) EditPhotoModel *model;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@end

@implementation EditCertificateViewController

- (EditPhotoModel *)model{
    if (!_model) {
        _model = [EditPhotoModel new];
        _model.type = @"certificate";
    }
    return _model;
}

- (instancetype)initWithPhotoModel:(EditPhotoModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"店铺资质";
    [self.view addSubview:self.scrollView];
    self.scrollView.zoomScale = 2;
    
    UILabel *lab = [UILabel labelWithFont:Font_PingFang_SC_Bold(36) text:@"点击上传" textColor:LZOrangeColor];
    [self.scrollView addSubview:lab];
    
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(self.contentHeight);
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.imageView);
    }];
    
    if (_model.url) {
        [_imageView sd_setImageWithURL:TLURL(_model.url) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
    }
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"上传" font:nil color:nil block:^{
        @strongify(self);
        [self uploadImage];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:tap];
}

- (void)didTap{
    
    [[ZLOnePhoto shareInstance] presentPicker:PickerType_Photo photoCut:PhotoCutType_NO target:self callBackBlock:^(UIImage *image, BOOL isCancel) {
        if (!isCancel) {
            
            self.imageView.image = image;
            self.model.image = image;
            self.image = image;
        }
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}


- (void)uploadImage{
    
    if (!self.image) {
        [self showMessage:@"请选择要上传的店铺资质!"];
        return;
    }
    
    [ZZNetWorker uploadImage1:self.image block:^(BOOL isSuccess, NSString *url) {
        dispatch_main_async_safe(^{
            
            if (isSuccess) {
                self.model.url = url;
                if (self.finishBlock) {
                    self.finishBlock(self.model);
                }
            }
            [self lz_popController];
        });
        
    }];
}
@end
