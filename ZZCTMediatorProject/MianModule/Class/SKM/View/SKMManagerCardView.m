//
//  SKMManagerCardView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SKMManagerCardView.h"

static CGFloat scale = 0.0;
@implementation SKMIconView

- (void)initUI{
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Regular(scale*9) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(scale*-5);
    }];
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"skm_alipay")];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(scale*-10);
    }];
    
    _label = label_title;
    _imageView = imageView;
}

@end

@interface SKMManagerCardView ()

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat WHscale;


@end

@implementation SKMManagerCardView

- (instancetype)initWithWidth:(CGFloat)width{
    
    CGFloat WHscale = 458.0f/315.0f;
    self = [super initWithFrame:CGRectMake(0, 0, width, WHscale*width)];
    if (self) {
        _WHscale = WHscale;
        _scale = width/315.0f;
        scale = _scale;
        
        [self creatUI];
        self.backgroundColor = LZWhiteColor;
        self.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.1), CGSizeMake(0, 2.5), 1, 7.5);
    }
    return self;
}

- (void)creatUI{
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(33*self.scale) text:@"请在此扫码付款" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    label_title.backgroundColor = rgb(255,91,14);
    [self addSubview:label_title];
    
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(self.scale*94.0f);
    }];
    
    UIView *iconView = [UIView new];
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scale*25);
        make.right.mas_equalTo(-self.scale*25);
        make.height.mas_equalTo(self.scale*55);
        make.top.mas_equalTo(label_title.mas_bottom).offset(self.scale*15);
    }];
    
    NSArray *titleArray = @[@"微信",@"支付宝",@"花呗",@"信用卡",];
    NSArray *imageArray = @[@"skm_weixinzhifu",@"skm_zhifubao",@"skm_huabei",@"skm_yinlian",];
    
    UIView *lastView = nil;
    for (int i = 0; i < titleArray.count; i++) {
        SKMIconView *icon = [SKMIconView new];
        icon.label.text = titleArray[i];
        icon.imageView.image = UIImageName(imageArray[i]);
        [iconView addSubview:icon];
        
        if (!lastView) {
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.bottom.mas_equalTo(0);
            }];
        }else if (i == titleArray.count-1) {
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.left.mas_equalTo(lastView.mas_right);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(lastView);
            }];
        }else {
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_right);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(lastView);
            }];
        }
        
        lastView = icon;
    }
    
    
    UIImageView *codeImageView = [UIImageView new];
    [self addSubview:codeImageView];
    
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.scale*172);
        make.size.mas_equalTo(CGSizeMake(195*self.scale, 195*self.scale));
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = rgb(255,91,14);
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(self.scale*68.5f);
    }];
    
    UILabel *label_appName = [UILabel labelWithFont:Font_PingFang_SC_Medium(16*self.scale) text:CurrentUserMerchant.pmsMerchantInfo.shortMerchantName textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [bottomView addSubview:label_appName];
    [label_appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomView.mas_centerY).offset(-3);
        make.centerX.mas_equalTo(bottomView);
    }];
    
    UILabel *label_info = [UILabel labelWithFont:Font_PingFang_SC_Medium(11*self.scale) text:@"" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [bottomView addSubview:label_info];
    [label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_centerY).offset(3);
        make.centerX.mas_equalTo(bottomView);
    }];
 
//    NSString *kefuPhone = [AppCenter KeFuPhone];
    label_info.text = [NSString stringWithFormat:@"怕钱不够花，就做副业吧！"];
    
    _codeImageView = codeImageView;
    _label_info = label_info;
    
}

@end
