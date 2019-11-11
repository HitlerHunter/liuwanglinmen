//
//  ShareInterfaceCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ShareInterfaceCell.h"

@interface ShareInterfaceCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation ShareInterfaceCell

+ (ShareInterfaceCell *)cellWithLogo:(UIImage *)logo
                               title:(NSString *)title
                             subTitle:(NSString *)subTitle
                            btnTitle:(NSString *)btnTitle
                               block:(void (^)(void))block{
    ShareInterfaceCell *cell = [ShareInterfaceCell new];
    cell.title = title;
    cell.subTitle = subTitle;
    cell.btnTitle = btnTitle;
    cell.block = block;
    cell.imageView.image = logo;
    return cell;
};

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
    }];
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"二维码图片链接" textColor:rgb(53,53,53)];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.top.mas_equalTo(imageView.mas_top).offset(-5);
        make.right.mas_equalTo(-100);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"识别二维码下载注册一起玩" textColor:rgb(152,152,152)];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1);
        make.bottom.mas_equalTo(imageView.mas_bottom).offset(1);
        make.right.mas_equalTo(label1);
    }];
    
    UIButton *btn = [UIButton buttonWithFontSize:12 text:@"马上邀请" textColor:rgb(255,81,0)];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 24));
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-18);
    }];
    
    btn.lz_setView.lz_cornerRadius(12).lz_border(1, rgb(255,81,0));
    
    _imageView = imageView;
    _titleLabel = label1;
    _subTitleLabel = label2;
    _btn = btn;
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addBottomLine];
    [self setBottomLineX:8];
    
//    self.lz_setView.lz_cornerRadius(4);
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle{
    _subTitle = subTitle;
    _subTitleLabel.text = subTitle;
}

- (void)setBtnTitle:(NSString *)btnTitle{
    _btnTitle = btnTitle;
    
    CGFloat w = [btnTitle tt_sizeWithFont:Font_PingFang_SC_Regular(12)].width+24;
    [_btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(w, 24));
    }];
    
    [_btn setTitle:btnTitle forState:UIControlStateNormal];
}

- (void)btnClick{
    if (_block) {
        _block();
    }
}
@end
