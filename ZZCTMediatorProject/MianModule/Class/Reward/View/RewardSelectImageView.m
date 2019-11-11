//
//  RewardSelectImageView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardSelectImageView.h"
#import "ZLOnePhoto.h"

@interface RewardSelectImageView ()<LDActionSheetDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageView_camara;
@end

@implementation RewardSelectImageView

- (void)initUI{
    
    UILabel *titleLab = [UILabel labelWithFontSize:15 textColor:UIColorHex(0x3A3A3A)];
    titleLab.text = @"请上传授权书照片";
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(23);
    }];
    _titleLabel = titleLab;
    
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = rgb(249,249,249);
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(11);
        make.left.mas_equalTo(titleLab);
        make.width.mas_equalTo(kScreenWidth*0.4);
        make.height.mas_equalTo(imageView.mas_width).multipliedBy(97.0/154);
    }];
    
    UIImageView *imageView1 = [UIImageView new];
    imageView1.backgroundColor = rgb(249,249,249);
    imageView1.userInteractionEnabled = YES;
    [self addSubview:imageView1];
    _imageView = imageView1;
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(imageView);
        make.height.mas_equalTo(imageView);
    }];
    
    UIImageView *imageView_camara = [UIImageView viewWithImage:UIImageName(@"reward_shangchuan")];
    imageView_camara.backgroundColor = rgb(249,249,249);
    [self addSubview:imageView_camara];
    _imageView_camara = imageView_camara;
    
    [imageView_camara mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(imageView1);
        make.size.mas_equalTo(CGSizeMake(47, 47));
    }];
    
    
    UILabel *infoLab = [UILabel labelWithFontSize:12 textColor:rgb(152,152,152)];
    infoLab.numberOfLines = 0;
    infoLab.text = @"授权书附件上传说明授权书附件上传说明授权书附件上传说明授权书附件上传说明授权书附件上传说明授权书附件上传说明";
    [self addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(16);
        make.bottom.mas_equalTo(-5);
    }];
    _infoLabel = infoLab;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAlertView)];
    [imageView1 addGestureRecognizer:tap];
}

- (void)showAlertView{
    LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [sheet showInView:KeyWindow];
    
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[ZLOnePhoto shareInstance] presentPicker:PickerType_Photo photoCut:PhotoCutType_NO target:self.topViewController callBackBlock:^(UIImage *image, BOOL isCancel) {
            if (!isCancel) {
                self.imageView.image = image;
                self.image = image;
                self.imageView_camara.hidden = image;
            }
        }];
    }else if (buttonIndex == 1) {
        [[ZLOnePhoto shareInstance] presentPicker:PickerType_Camera photoCut:PhotoCutType_NO target:self.topViewController callBackBlock:^(UIImage *image, BOOL isCancel) {
            if (!isCancel) {
                self.imageView.image = image;
                self.image = image;
                self.imageView_camara.hidden = image;
            }
        }];
    }
}

@end
