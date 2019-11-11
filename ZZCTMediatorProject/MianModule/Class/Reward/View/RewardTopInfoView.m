//
//  RewardTopInfoView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardTopInfoView.h"

@implementation RewardTopInfoView

- (void)initUI{
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"reward_textBg")];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UILabel *lab = [UILabel labelWithFontSize:11 text:@"悬赏功能说明\n1.悬赏费率设置为1%的整数倍；\n2.商户设置悬赏后，符合悬赏标准的交易金额，将被扣除悬赏费率对应的悬赏金，余额会到达商户绑定的银行账户；\n3.发布或下架悬赏功能，需要2个工作日以内的审核时间。"
                                    textColor:LZWhiteColor];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 10, 15, 10));
    }];
    
}

@end
