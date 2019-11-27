//
//  GoodsDetailTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "GoodsDetailTopView.h"
#import <SDCycleScrollView.h>
#import "GoodsModel.h"

@interface GoodsDetailTopView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) GoodsModel *model;
@property (nonatomic, strong) UILabel *lab_count;

@end

@implementation GoodsDetailTopView

- (instancetype)initWithGoodsModel:(GoodsModel *)model{
    self = [super init];
    if (self) {
        _model = model;
        [self initUI1];
    }
    return self;
}

- (void)initUI1{
    [self addSubview:self.cycleScrollView];
    
    UIView *view1 = [UIView new];
    view1.frame = CGRectMake(0, self.cycleScrollView.bottom-10, kScreenWidth, 55);
    [self addSubview:view1];
    [view1 setDefaultGradientWithCornerRadius:10];
    
    UILabel *lab_money = [UILabel labelWithFontSize:26 textColor:LZWhiteColor];
    [view1 addSubview:lab_money];
    
    UILabel *lab_submoney = [UILabel labelWithFontSize:14 textColor:rgb(248,248,248)];
    [view1 addSubview:lab_submoney];
    
    [lab_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(-5);
    }];
    [lab_submoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab_money.mas_right).offset(10);
        make.centerY.mas_equalTo(-5);
    }];
    
    UILabel *lab1 = [UILabel labelWithFontSize:14 text:@"人成功购买" textColor:rgb(255,234,233)];
    [view1 addSubview:lab1];
    UILabel *lab_count = [UILabel labelWithFontSize:14 text:@"" textColor:rgb(255,81,0) textAlignment:NSTextAlignmentCenter];
    lab_count.backgroundColor = rgb(255,234,233);
    [view1 addSubview:lab_count];
    UILabel *lab2 = [UILabel labelWithFontSize:14 text:@"已有" textColor:rgb(255,234,233)];
    [view1 addSubview:lab2];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(-5);
    }];
    [lab_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lab1.mas_left).offset(-1);
        make.centerY.mas_equalTo(lab1);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(20);
    }];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lab_count.mas_left).offset(-1);
        make.centerY.mas_equalTo(lab1);
    }];
    
    _lab_count = lab_count;
    lab_count.lz_setView.lz_cornerRadius(3);
    
    //view2
    UIView *view2 = [UIView new];
    view2.backgroundColor = LZWhiteColor;
    view2.frame = CGRectMake(0, view1.bottom-10, kScreenWidth, 55);
    [self addSubview:view2];
    UILabel *lab_name = [UILabel labelWithFontSize:15 text:@"" textColor:rgb(53,53,53)];
    lab_name.numberOfLines = 2;
    [view2 addSubview:lab_name];
    [lab_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    //imageview
    UIView *logoview = [[UIView alloc] initWithFrame:CGRectMake(0, view2.bottom, kScreenWidth, 34)];
    logoview.backgroundColor = rgba(255,81,0,0.08);
    [self addSubview:logoview];
    
    UIImageView *imav = [UIImageView viewWithImage:UIImageName(@"GoodsDetail_fxg")];
    imav.contentMode = UIViewContentModeScaleAspectFit;
    [logoview addSubview:imav];
    [imav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth*0.25);
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    UIButton *btn1 = [UIButton buttonWithFontSize:14 text:@"正品承诺" textColor:rgb(255,81,0)];
    [btn1 setImage:UIImageName(@"GoodsDetail_xuanze") forState:UIControlStateNormal];
    [logoview addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth*0.25);
        make.left.mas_equalTo(imav.mas_right);
        make.centerY.mas_equalTo(0);
    }];
    UIButton *btn2 = [UIButton buttonWithFontSize:14 text:@"快递免邮" textColor:rgb(255,81,0)];
    [btn2 setImage:UIImageName(@"GoodsDetail_xuanze") forState:UIControlStateNormal];
    [logoview addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth*0.25);
        make.left.mas_equalTo(btn1.mas_right);
        make.centerY.mas_equalTo(0);
    }];
    UIButton *btn3 = [UIButton buttonWithFontSize:14 text:@"无忧售后" textColor:rgb(255,81,0)];
    [btn3 setImage:UIImageName(@"GoodsDetail_xuanze") forState:UIControlStateNormal];
    [logoview addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth*0.25);
        make.left.mas_equalTo(btn2.mas_right);
        make.centerY.mas_equalTo(0);
    }];
    
    /*
    //view4
    UIView *view4 = [UIView new];
    view4.backgroundColor = LZWhiteColor;
    view4.frame = CGRectMake(0, imageview.bottom, kScreenWidth, 38);
    [self addSubview:view4];
    UILabel *lab41 = [UILabel labelWithFontSize:14 text:@"发货" textColor:rgb(152,152,152)];
    [view4 addSubview:lab41];
    [lab41 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    UIImageView *icon = [UIImageView viewWithImage:UIImageName(@"location_gray")];
    [view4 addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab41.mas_right).offset(20);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *lab_address = [UILabel labelWithFontSize:14 text:@"发货" textColor:rgb(53,53,53)];
    [view4 addSubview:lab_address];
    [lab_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(226,226,226);
    [view4 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab_address.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, 14));
    }];
    
    UILabel *lab42 = [UILabel labelWithFontSize:14 text:@"快递：免邮" textColor:rgb(53,53,53)];
    [view4 addSubview:lab42];
    [lab42 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
    }];
     
     */
    
    //imageview
       UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, logoview.bottom, kScreenWidth, 31)];
       view5.backgroundColor = LZWhiteColor;
       [self addSubview:view5];
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(242,242,242);
    [view5 addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(155, 1));
    }];
    
    UILabel *lab51 = [UILabel labelWithFontSize:12 text:@"宝贝详情" textColor:rgb(101,101,101) textAlignment:NSTextAlignmentCenter];
    lab51.backgroundColor = LZWhiteColor;
    [view5 addSubview:lab51];
    [lab51 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(68);
    }];
    
    self.height = view5.bottom;
    self.backgroundColor = rgb(242,242,242);
    
    lab_money.text = [NSString stringWithFormat:@"￥%@",_model.orderAmt];
    
    NSString *sourceAmount = [NSString stringWithFormat:@"￥%@",_model.goodsPrice];
     NSMutableAttributedString *attPrice2 = [[NSMutableAttributedString alloc]initWithString:sourceAmount];
     [attPrice2 addAttribute:NSBaselineOffsetAttributeName value:@(0) range:NSMakeRange(0,sourceAmount.length)];
     [attPrice2 addAttribute:NSStrikethroughStyleAttributeName
                      value:@(NSUnderlinePatternSolid |
    NSUnderlineStyleSingle)
                       range:NSMakeRange(0,sourceAmount.length)];
    [attPrice2 addAttribute:NSFontAttributeName value:Font_PingFang_SC_Regular(15) range:NSMakeRange(0,attPrice2.length)];
    [attPrice2 addAttribute:NSForegroundColorAttributeName value:LZWhiteColor range:NSMakeRange(0,attPrice2.length)];
    lab_submoney.attributedText = attPrice2;
    
    lab_name.text = _model.goodsName;
//    lab_address.text = @"湖南长沙";
    
    self.cycleScrollView.imageURLStringsGroup = _model.topArray;
    
    [self requestBuyCount];
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        CGFloat width = kScreenWidth;
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, width) delegate:self placeholderImage:nil];
        _cycleScrollView.autoScrollTimeInterval = 9;
        _cycleScrollView.showPageControl = YES;
//        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}

- (void)requestBuyCount{
 
    ZZNetWorker.GET.zz_param(@{})
    .zz_url(@"/outside-biz/expressInfo/countBought")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            self.lab_count.text = [NSString stringWithFormat:@"%@",model_net.data];
            
            CGFloat w = [self.lab_count.text tt_sizeWithFont:self.lab_count.font].width+15;
            [self.lab_count mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(w);
            }];
        }
    });
}
@end
