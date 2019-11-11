//
//  VipPersonDetailTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipPersonDetailTopView.h"

@implementation VipPersonDetailTopView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    

    UIImageView *imageView = [UIImageView new];
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    
    _headImage = imageView;
    _label_name = label_name;
    _label_phone = label_phone;
    
    [self addSubview:imageView];
    [self addSubview:label_name];
    [self addSubview:label_phone];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(imageView.mas_right).offset(11);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom).offset(5);
    }];
    
    imageView.lz_setView.lz_cornerRadius(25);
    
   
}

@end
