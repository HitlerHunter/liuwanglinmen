//
//  MineOrderDetailStatusView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineOrderDetailStatusView.h"
#import "MineOrderModel.h"
#import "NSDate+countDown.h"

@interface MineOrderDetailStatusView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleLabel2;
@end

@implementation MineOrderDetailStatusView

- (void)initUI{
    
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-58);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *titleLabel = [UILabel labelWithFontSize:16 textColor:rgb(255,255,255)];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.centerY.mas_equalTo(-15);
    }];
    
    UILabel *titleLabel2 = [UILabel labelWithFontSize:11 textColor:rgb(255,255,255)];
    [self addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel);
        make.centerY.mas_equalTo(10);
    }];
    
    _titleLabel = titleLabel;
    _titleLabel2 = titleLabel2;
    _imageView = imageView;
}

- (void)setModel:(MineOrderModel *)model{
    _model = model;
    
    if (_model.status == MineOrderStatusWaitingPay) {
        _titleLabel.text = @"待付款";
        
        weakSelf(weakSelf);
        [NSDate countDownSinceDateBeginStr:model.createTime TimeInterval:1800 block:^(NSString * _Nonnull HMSString) {
            weakSelf.titleLabel2.text = [NSString stringWithFormat:@"剩余时间：%@",HMSString];
        }];
        
        _imageView.image = UIImageName(@"order_waitingPay");
    }else if (_model.status == MineOrderStatusCancel) {
        _titleLabel.text = @"交易关闭";
        self.titleLabel2.text = @"订单超时";
        _imageView.image = UIImageName(@"order_hasCancel");
    }else if (_model.status == MineOrderStatusWaitingTake) {
        _titleLabel.text = @"卖家已发货";
        self.titleLabel2.text = @"您的订单已发货";
      _imageView.image = UIImageName(@"order_hasSend");
    }else if (_model.status == MineOrderStatusWaitingSend) {
        _titleLabel.text = @"买家已付款";
        self.titleLabel2.text = @"您的订单待配货";
       _imageView.image = UIImageName(@"order_hasPay");
    }
}
 
- (void)dealloc{
    [NSDate stopCountDown];
}
@end

