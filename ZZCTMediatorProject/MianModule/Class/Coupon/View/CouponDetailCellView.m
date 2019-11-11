//
//  CouponDetailCellView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponDetailCellView.h"

@implementation CouponDetailCellModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

@end

@interface CouponDetailCell ()

@end

@implementation CouponDetailCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"" textColor:rgb(152,152,152)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"" textColor:rgb(53,53,53)];
    label_phone.numberOfLines = 0;
    
    _label_title = label_name;
    _label_vaule = label_phone;

    [self addSubview:label_name];
    [self addSubview:label_phone];
 
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.mas_equalTo(10);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(126);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(label_name);
        make.height.mas_greaterThanOrEqualTo(16);
        make.bottom.mas_equalTo(-10);
    }];
  
}

- (void)setModel:(CouponDetailCellModel *)model{
    _model = model;
    
    self.label_title.text = model.title;
    self.label_vaule.text = model.vaule;
    
    self.label_vaule.textAlignment = model.textAlignment;
    
    @weakify(self);
    [RACObserve(model, vaule) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.label_vaule.text = x;
    }];
    

}

@end

@interface CouponDetailCellView ()

@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation CouponDetailCellView

- (void)setDataArray:(NSArray<CouponDetailCellModel *> *)dataArray{
    _dataArray = dataArray;
    
    _cellArray = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i++) {
        CouponDetailCell *cell = [CouponDetailCell new];
        CouponDetailCellModel *model = dataArray[i];
        cell.model = model;
        [self addSubview:cell];
        
        if (!self.cellArray.count) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self);
                make.top.mas_equalTo(5);
                make.height.mas_greaterThanOrEqualTo(30);
            }];
        }else {
            CouponDetailCell *lastCell = self.cellArray.lastObject;
            
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self);
                make.height.mas_greaterThanOrEqualTo(30);
                make.top.mas_equalTo(lastCell.mas_bottom);
            }];
        }
        
        if (i == dataArray.count-1){
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-5);
            }];
        }
        
        [self.cellArray addObject:cell];
    }
    
}



@end
