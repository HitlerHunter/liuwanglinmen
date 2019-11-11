//
//  AuthenMerchantTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantTopView.h"

@interface AuthenMerchantTopView ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@end

@implementation AuthenMerchantTopView

- (void)initUI{
    
    UILabel *label1 = [UILabel labelWithFontSize:13 text:@"基本信息" textAlignment:NSTextAlignmentCenter];
    UILabel *label2 = [UILabel labelWithFontSize:13 text:@"结算信息" textAlignment:NSTextAlignmentCenter];
    UILabel *label3 = [UILabel labelWithFontSize:13 text:@"上传附件" textAlignment:NSTextAlignmentCenter];
    
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0).offset(-kScreenWidth/3-10);
        make.top.mas_equalTo(13);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(13);
    }];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0).offset(kScreenWidth/3+10);
        make.top.mas_equalTo(13);
    }];
    
    //view
    UIView *line = [UIView new];
    line.tag = 101;
    line.backgroundColor = rgb(234,234,234);
    
    UIView *view1 = [UIView new];
    view1.lz_setView.lz_cornerRadius(5);
    view1.backgroundColor = rgb(234,234,234);
    
    UIView *view2 = [UIView new];
    view2.lz_setView.lz_cornerRadius(5);
    view2.backgroundColor = rgb(234,234,234);
    
    UIView *view3 = [UIView new];
    view3.lz_setView.lz_cornerRadius(5);
    view3.backgroundColor = rgb(234,234,234);
    
    [self addSubview:line];
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_centerX).offset(-10);
        make.right.mas_equalTo(label3.mas_centerX).offset(10);
        make.top.mas_equalTo(label1.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(line.mas_left);
        make.centerY.mas_equalTo(line);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    view1.lz_setView.lz_cornerRadius(5);
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(line);
        make.centerY.mas_equalTo(line);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    view2.lz_setView.lz_cornerRadius(5);
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(line.mas_right);
        make.centerY.mas_equalTo(line);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    view3.lz_setView.lz_cornerRadius(5);
    
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = rgb(255,81,0);
    
    UIImageView *imageView1 = [UIImageView new];
    UIImageView *imageView2 = [UIImageView new];
    UIImageView *imageView3 = [UIImageView new];
    
    [self addSubview:line2];
    [self addSubview:imageView1];
    [self addSubview:imageView2];
    [self addSubview:imageView3];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.height.mas_equalTo(line);
    }];
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view1);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    imageView1.lz_setView.lz_cornerRadius(10);
    
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view2);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    imageView2.lz_setView.lz_cornerRadius(10);
    
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(view3);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    imageView3.lz_setView.lz_cornerRadius(10);
    
    
    _line = line2;
    _imageView1 = imageView1;
    _imageView2 = imageView2;
    _imageView3 = imageView3;
    
    imageView1.backgroundColor = rgb(255,81,0);
    imageView2.backgroundColor = rgb(255,81,0);
    imageView3.backgroundColor = rgb(255,81,0);
}

- (void)setStep:(NSInteger)step{
    _step = step;
    
    if (step == 1) {
        _line.hidden = YES;
        _imageView1.hidden = NO;
        _imageView2.hidden = YES;
        _imageView3.hidden = YES;
    }else if (step == 2) {
        _line.hidden = NO;
        _imageView1.hidden = NO;
        _imageView2.hidden = NO;
        _imageView3.hidden = YES;
        
        UIView *line = [self viewWithTag:101];
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.height.mas_equalTo(line);
            make.right.mas_equalTo(line.mas_centerX);
        }];
        
    }else if (step == 3) {
        _line.hidden = NO;
        _imageView1.hidden = NO;
        _imageView2.hidden = NO;
        _imageView3.hidden = NO;
        
        [_line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.imageView3.mas_centerX);
        }];
    }
}

@end
