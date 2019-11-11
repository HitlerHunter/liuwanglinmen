//
//  AuthenMerchantPhotoView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantPhotoView.h"
#import "ZLOnePhoto.h"

@implementation AuthenMerchantPhotoModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _canEdit = YES;
    }
    return self;
}

@end

@interface AuthenMerchantPhotoItem ()<LDActionSheetDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation AuthenMerchantPhotoItem

- (void)initUI{
    
    UILabel *lab = [UILabel labelWithFontSize:11 text:@"" textColor:rgb(101,101,101)];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(16);
    }];
    
    _titleLabel = lab;
    
    UIImageView *bgImageView = [UIImageView new];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(lab.mas_top).offset(-10);
    }];
    
    UIImageView *addImageView = [UIImageView viewWithImage:UIImageName(@"tianjia")];
    [bgImageView addSubview:addImageView];
    [addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    addImageView.lz_setView.lz_cornerRadius(20);
    
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(bgImageView);
    }];
    
    _bgImageView = bgImageView;
    _addImageView = addImageView;
    _imageView = imageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
    bgImageView.userInteractionEnabled = YES;
    [bgImageView addGestureRecognizer:tap];
    
}

- (void)imageViewTap{
    LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheet showInView:KeyWindow];
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [[ZLOnePhoto shareInstance] presentPicker:PickerType_Camera photoCut:PhotoCutType_NO target:self.viewController callBackBlock:^(UIImage *image, BOOL isCancel) {
            if (!isCancel) {
                
                [self uploadImage:image];
            }
        }];
    }else if (buttonIndex == 1) {
        [[ZLOnePhoto shareInstance] presentPicker:PickerType_Photo photoCut:PhotoCutType_NO target:self.viewController callBackBlock:^(UIImage *image, BOOL isCancel) {
            if (!isCancel) {
                [self uploadImage:image];
            }
        }];
    }
}

- (void)uploadImage:(UIImage *)image{
    [ZZNetWorker uploadImage1:image block:^(BOOL isSuccess, NSString *url) {
        if (isSuccess) {
            self.imageView.image = image;
            self.imageView.hidden = NO;
            self.model.imageUrl = url;
        }
    }];
}

- (void)setModel:(AuthenMerchantPhotoModel *)model{
    _model = model;
    
    if (!IsNull(model.imageUrl)) {
        [self.imageView sd_setImageWithURL:TLURL(model.imageUrl)];
        self.imageView.hidden = NO;
    }
    
    if (model.bgImageName) {
        self.bgImageView.image = UIImageName(model.bgImageName);
    }
    
    if (model.title) {
        self.titleLabel.text = model.title;
    }
    
}

@end

@interface AuthenMerchantPhotoView ()

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation AuthenMerchantPhotoView

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

- (void)setDataArray:(NSArray<AuthenMerchantPhotoModel *> *)dataArray{
    _dataArray = dataArray;
    
    CGSize itemSize = CGSizeMake(kScreenWidth*0.4, kScreenWidth*0.3);
    UIView *lastView = nil;
    for (int i = 0; i < dataArray.count; i++) {
        AuthenMerchantPhotoItem *item = [AuthenMerchantPhotoItem new];
        item.model = dataArray[i];
        [self addSubview:item];
        
        if (i%2 == 0) {
            if (!lastView) {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(0).offset(-kScreenWidth/4);
                    make.size.mas_equalTo(itemSize);
                    make.top.mas_equalTo(42);
                }];
            }else {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(0).offset(-kScreenWidth/4);
                    make.size.mas_equalTo(itemSize);
                    make.top.mas_equalTo(lastView.mas_bottom).offset(10);
                }];
            }
        }else {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0).offset(kScreenWidth/4);
                make.size.mas_equalTo(itemSize);
                make.top.mas_equalTo(lastView);
            }];
        }
        
        lastView = item;
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
    }];
    
    
}

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(255,81,0);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(3, 12));
    }];
    line.lz_setView.lz_cornerRadius(2);
    
    UILabel *lab = [UILabel labelWithFontSize:12 text:@"" textColor:rgb(18,18,18)];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21);
        make.centerY.mas_equalTo(line);
    }];
    
    _titleLabel = lab;
    
}



@end

