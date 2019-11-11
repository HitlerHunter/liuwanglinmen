//
//  CouponSendResultController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponSendResultController.h"
#import "CouponDetailCellView.h"

@interface CouponSendResultController ()

@property (nonatomic, assign) NSInteger sendCount;
@property (nonatomic, strong) CouponDetailCellView *cellView1;
@end

@implementation CouponSendResultController

- (instancetype)initWithSendCount:(NSInteger)count{
    self = [super init];
    if (self) {
        _sendCount = count;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"结果详情";
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"coupon_sendSuccess")];
//    imageView.backgroundColor = LZWhiteColor;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62, 62));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(78+self.base_navigationbarHeight);
    }];
    
    UILabel *title_label = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"发送成功" textColor:rgb(53,53,53)];
    [self.view addSubview:title_label];
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(imageView);
    }];
    
    [self initCellView1];
}

- (void)initCellView1{
    NSArray *titleArray = @[@"发送数量",@"发送时间",];
    NSMutableArray *vauleArray = [NSMutableArray array];
    [vauleArray addObject:[NSString stringWithFormat:@"%ld张",self.sendCount]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:MM:ss";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    [vauleArray addObject:dateStr];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        CouponDetailCellModel *model = [CouponDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        model.textAlignment = NSTextAlignmentRight;
        [arr1 addObject:model];
    }
    
    _cellView1 = [CouponDetailCellView new];
    _cellView1.backgroundColor = LZWhiteColor;
    _cellView1.dataArray = arr1;
    [self.view addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(200+self.base_navigationbarHeight);
    }];
    
    _cellView1.lz_setView.lz_cornerRadius(6);
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"完成" textColor:LZWhiteColor];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(70);
    }];
    [btn setDefaultGradientWithCornerRadius:22];
    
    @weakify(self);
    [btn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [self lineBackWithId:LinearBackId_AuthenLine];
    }];
}

@end
