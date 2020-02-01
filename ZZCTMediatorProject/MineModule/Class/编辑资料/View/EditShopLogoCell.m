//
//  EditShopLogoCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditShopLogoCell.h"
#import "ZLOnePhoto.h"
#import "LZImageResizerViewController.h"

@interface EditShopLogoCell ()<LZImageResizerDelegate>

@end

@implementation EditShopLogoCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFontSize:14 textColor:rgb(101,101,101)];
    UILabel *text_label = [UILabel labelWithFontSize:14 textColor:rgb(53,53,53)];
    text_label.textAlignment = NSTextAlignmentRight;
    UIImageView *rightIcon = [UIImageView viewWithImage:UIImageName(@"more_gray")];
    UIImageView *leftIcon = [UIImageView viewWithImage:[AppCenter appIcon]];
    _logoImageView = leftIcon;
    leftIcon.hidden = YES;
    
    [self addSubview:title_label];
    [self addSubview:text_label];
    [self addSubview:rightIcon];
    [self addSubview:leftIcon];
    
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(7);
    }];
    
    [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightIcon.mas_left).offset(-10);
        make.centerY.mas_equalTo(self);
    }];
    
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(text_label.mas_right);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    _title_label = title_label;
    _text_label = text_label;
    
    leftIcon.lz_setView.lz_cornerRadius(3);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:tap];
}

- (void)didTap{
    
    [[ZLOnePhoto shareInstance] presentPicker:PickerType_Photo photoCut:PhotoCutType_NO target:self.topViewController callBackBlock:^(UIImage *image, BOOL isCancel) {
        if (!isCancel) {
            
            LZImageResizerViewController *resizeVC = [[LZImageResizerViewController alloc] initWithImage:image];
            resizeVC.imageResizerDelegate = self;
            [self.topViewController.navigationController pushViewController:resizeVC animated:YES];
        }
    }];
}

- (void)LZImageResizerDidResizeImage:(UIImage *_Nonnull)resizeImage{
    
    [ZZNetWorker uploadImage1:resizeImage block:^(BOOL isSuccess, NSString *url) {
        dispatch_main_async_safe(^{
            self.logoImageView.image = resizeImage;
            self.logoImage = resizeImage;
            self.text_label.hidden = YES;
            if (self.didUploadLogoBlock) {
                self.didUploadLogoBlock(url);
            }
        });
        
    }];
}
- (UIImageView *_Nullable)didTapImageView{
    return _logoImageView;
}

- (void)setTitle:(NSString *)title{
    _title_label.text = title;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.text_label.text = text;
}

- (void)setLogoImage:(UIImage *)logoImage{
    _logoImage = logoImage;
    
    _logoImageView.image = logoImage;
    _logoImageView.hidden = NO;
    _text_label.hidden = YES;
}
- (void)setLogoUrl:(NSString *)logoUrl{
    _logoUrl = logoUrl;
    
    if (logoUrl.length>0) {
        [_logoImageView sd_setImageWithURL:TLURL(logoUrl)];
        _logoImageView.hidden = NO;
        _text_label.hidden = YES;
    }
}

@end
