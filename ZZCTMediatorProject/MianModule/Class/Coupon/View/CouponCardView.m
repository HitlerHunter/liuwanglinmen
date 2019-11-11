//
//  CouponCardView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponCardView.h"
#import "CouponModel.h"

@interface CouponLeftCard ()

@property (nonatomic, assign) CGFloat radius;
@end

@implementation CouponLeftCard

- (void)drawRect:(CGRect)rect{
    
    _radius = 5;//半径
    
    [self drawCor:rect];
}

- (void)drawCor:(CGRect)rect {
        // Drawing code
    
        // 画圆
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    
//    UIBezierPath *path = [UIBezierPath bezierPath]
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path,NULL, _radius,0);
    CGPathAddLineToPoint(path,NULL, self.width-_radius, 0);
    
    CGPathAddArc(path,NULL, self.width, 0, _radius, -M_PI, -M_PI-M_PI_2, YES);
    CGPathAddLineToPoint(path,NULL, self.width, _radius);
    
    CGPathAddLineToPoint(path,NULL, self.width, self.height-_radius);
    CGPathAddArc(path,NULL, self.width, self.height, _radius, -M_PI_2, -M_PI, YES);
    
    CGPathAddLineToPoint(path,NULL, self.width-_radius, self.height);//左下角
    CGPathAddLineToPoint(path,NULL, _radius, self.height);
    CGPathAddCurveToPoint(path, NULL, 0, self.height, 0, self.height, 0, self.height-_radius);
    
    CGPathAddLineToPoint(path,NULL, 0, self.height-_radius);
    CGPathAddLineToPoint(path,NULL, 0, _radius);
    CGPathAddCurveToPoint(path, NULL, 0, 0, 0, 0, _radius, 0);
    CGPathAddLineToPoint(path,NULL, _radius,0);
    
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    self.layer.mask = shapeLayer;
    
}

@end

@interface CouponRightCard ()

@property (nonatomic, assign) CGFloat radius;
@end

@implementation CouponRightCard

- (void)drawRect:(CGRect)rect{
    
    _radius = 5;//半径
    
    [self drawCor:rect];
}

- (void)drawCor:(CGRect)rect {
        // Drawing code
    
        // 画圆
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor redColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path,NULL, _radius,0);
    CGPathAddLineToPoint(path,NULL, self.width-_radius, 0);
    CGPathAddCurveToPoint(path, NULL, self.width, 0, self.width, 0, self.width, _radius);
    
    CGPathAddLineToPoint(path,NULL, self.width, _radius);
    CGPathAddLineToPoint(path,NULL, self.width, self.height-_radius);
    CGPathAddCurveToPoint(path, NULL, self.width, self.height, self.width, self.height, self.width-_radius, self.height);
    
    CGPathAddLineToPoint(path,NULL, self.width-_radius, self.height);//左下角
    CGPathAddLineToPoint(path,NULL, _radius, self.height);
    CGPathAddArc(path,NULL, 0, self.height, _radius, 0, -M_PI_2, YES);
    
    CGPathAddLineToPoint(path,NULL, 0, self.height-_radius);
    CGPathAddLineToPoint(path,NULL, 0, _radius);
    CGPathAddArc(path,NULL, 0, 0, _radius, M_PI_2, 0, YES);
    CGPathAddLineToPoint(path,NULL, _radius,0);
    
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    self.layer.mask = shapeLayer;
    
    shapeLayer.cornerRadius = 1;
    shapeLayer.shadowColor = rgba(0, 0, 0, 0.8).CGColor;
    shapeLayer.shadowOffset = CGSizeMake(1, 2.5);
    shapeLayer.shadowOpacity = 1;
    shapeLayer.shadowRadius = 5;
    
}

@end



@interface CouponCardView ()

@property (nonatomic, strong) CouponLeftCard *leftView;
@property (nonatomic, strong) CouponRightCard *rightView;

@property (nonatomic, strong) UILabel *leftLabel_money;
@property (nonatomic, strong) UILabel *leftLabel_message;

@property (nonatomic, strong) UILabel *rightLabel_name;
@property (nonatomic, strong) UILabel *rightLabel_type;
@property (nonatomic, strong) UILabel *rightLabel_status;
@property (nonatomic, strong) UILabel *rightLabel_message;
@property (nonatomic, strong) UILabel *rightLabel_date;

@property (nonatomic, strong) UIImageView *logoImageView;
@end

@implementation CouponCardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.leftView = [CouponLeftCard new];
        self.leftView.backgroundColor = rgb(255,142,1);
        [self addSubview:self.leftView];
        
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self.leftView.mas_height).multipliedBy(1);
        }];
        
        self.rightView = [CouponRightCard new];
        self.rightView.backgroundColor = LZWhiteColor;
        [self addSubview:self.rightView];
        
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self.leftView.mas_right);
        }];
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UILabel *leftLabel_money = [UILabel labelWithFont:Font_PingFang_SC_Medium(20) text:@"￥500" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [self.leftView addSubview:leftLabel_money];
    [leftLabel_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.leftView);
        make.bottom.mas_equalTo(self.leftView.mas_centerY);
    }];
    
    UILabel *leftLabel_message = [UILabel labelWithFont:Font_PingFang_SC_Regular(13) text:@"满8000可用" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    leftLabel_message.numberOfLines = 2;
    [self.leftView addSubview:leftLabel_message];
    [leftLabel_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.leftView).offset(-5);
        make.left.mas_equalTo(self.leftView).offset(5);
        make.top.mas_equalTo(self.leftView.mas_centerY);
    }];
    
    
    UILabel *rightLabel_date = [UILabel labelWithFont:Font_PingFang_SC_Regular(11) text:@"有效期:2019.07.16-2019.08.16" textColor:rgb(152,152,152)];
    [self.rightView addSubview:rightLabel_date];
    [rightLabel_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *rightLabel_status = [UILabel labelWithFont:Font_PingFang_SC_Regular(11) text:@"" textColor:rgb(152,152,152)];
    [self.rightView addSubview:rightLabel_status];
    [rightLabel_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(rightLabel_date.mas_top).offset(-5);
        make.width.mas_equalTo(35);
    }];
    
    UILabel *rightLabel_message = [UILabel labelWithFont:Font_PingFang_SC_Regular(11) text:@"消费满8000元可用" textColor:rgb(152,152,152)];
    [self.rightView addSubview:rightLabel_message];
    [rightLabel_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rightLabel_date);
        make.centerY.mas_equalTo(rightLabel_status);
        make.right.mas_equalTo(rightLabel_status.mas_left).offset(-5);
    }];
    
    
    UILabel *rightLabel_name = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"全店通用代金券" textColor:rgb(53,53,53)];
    rightLabel_name.numberOfLines = 2;
    rightLabel_name.adjustsFontSizeToFitWidth = YES;
    [self.rightView addSubview:rightLabel_name];
    [rightLabel_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rightLabel_date);
        make.right.mas_equalTo(-60);
        make.bottom.mas_equalTo(rightLabel_message.mas_top).offset(-10);
        make.height.mas_lessThanOrEqualTo(34);
    }];
    
    UILabel *rightLabel_type = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"代金券" textColor:rgb(227,157,8) textAlignment:NSTextAlignmentCenter];
    [self.rightView addSubview:rightLabel_type];
    [rightLabel_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(rightLabel_name);
    }];
    
    UIImageView *logoImageView = [UIImageView new];
//    logoImageView.backgroundColor = [UIColor.grayColor colorWithAlphaComponent:0.05];
    logoImageView.hidden = YES;
    [self.rightView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.rightView);
        make.size.mas_equalTo(CGSizeMake(60, 46));
    }];
    
    _leftLabel_money = leftLabel_money;
    _leftLabel_message = leftLabel_message;
    
    _rightLabel_name = rightLabel_name;
    _rightLabel_type = rightLabel_type;
    _rightLabel_status = rightLabel_status;
    _rightLabel_message = rightLabel_message;
    _rightLabel_date = rightLabel_date;
    
    _logoImageView = logoImageView;
}

- (void)setModel:(CouponModel *)model{
    _model = model;
    
    self.rightLabel_name.text = model.couponName;
    
    NSString *type = getCouponTypeStrWithType(model.couponType);
    self.rightLabel_type.text = type;
    self.rightLabel_message.text = getCouponMessageWithCoupon(model);
    
    if ([type isEqualToString:@"代金券"]) {
        self.leftView.backgroundColor = rgb(254,190,52);
        self.rightLabel_type.textColor = rgb(227,157,8);
        
        self.leftLabel_money.text = [NSString stringWithFormat:@"￥%@",getCouponDiscountStrWithDiscountFloat(model.couponAmount)];
        self.leftLabel_message.text = [NSString stringWithFormat:@"满%@可用",getCouponDiscountStrWithDiscountFloat(model.couponLowerAmount)];
        
    }else if ([type isEqualToString:@"折扣券"]) {
       
        self.leftView.backgroundColor = rgb(255,143,2);
        self.rightLabel_type.textColor = rgb(255,81,0);
        
        self.leftLabel_money.text = [NSString stringWithFormat:@"%@折",getCouponDiscountStrWithDiscountFloat(model.couponDiscount)];
        
        if (model.couponHigherAmount > 0) {
            self.leftLabel_message.text = [NSString stringWithFormat:@"最高抵%@元",getCouponDiscountStrWithDiscountFloat(model.couponHigherAmount)];
          
        }else{
            self.leftLabel_message.text = @"无金额上限";
            
        }
        
    }
    
    if (model.validDateType == 1) {//永久有效
        self.rightLabel_date.text = @"有效期：永久有效";
    }else if(model.validDateType == 2 && model.startDate.length && model.endDate.length){//时效
        NSString *start = [model.startDate stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *end = [model.endDate stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        self.rightLabel_date.text = [NSString stringWithFormat:@"有效期：%@-%@",start,end];
    }
    
    NSString *status = getCouponStatusStrWithStatus(model.couponStatus);
    self.rightLabel_status.text = status;
    if ([status isEqualToString:@"已失效"]) {
        self.leftView.backgroundColor = rgb(152,152,152);
        self.rightLabel_type.textColor = rgb(193,193,193);
        self.logoImageView.hidden = NO;
        self.logoImageView.image = UIImageName(@"shixiao");
        self.rightLabel_status.hidden = YES;
    }else{
        self.logoImageView.hidden = YES;
        self.rightLabel_status.hidden = NO;
    }
}

@end
