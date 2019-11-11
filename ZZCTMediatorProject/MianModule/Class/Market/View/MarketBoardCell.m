//
//  MarketBoardCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketBoardCell.h"
#import "MarketBoardCellModel.h"

@implementation MarketBoardCell

- (void)initUI{
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"" textColor:rgb(53,53,53)];
    label_name.numberOfLines = 0;
    
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Regular(13) text:@"" textColor:rgb(152,152,152)];
    label_phone.numberOfLines = 0;
    
    UILabel *label_statu = [UILabel labelWithFont:Font_PingFang_SC_Regular(13) text:@"审核成功" textColor:rgb(152,152,152)];
    UIImageView *imageView_statu = [UIImageView new];
    
    _label_title = label_name;
    _label_info = label_phone;
    _label_status = label_statu;
    _imageView_statu = imageView_statu;
    
    [self addSubview:label_name];
    [self addSubview:label_phone];
    [self addSubview:label_statu];
    [self addSubview:imageView_statu];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(16);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    [label_statu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_name);
        make.right.mas_equalTo(label_name);
        make.height.mas_equalTo(16);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfClick)];
    [self addGestureRecognizer:tap];
    
    
}

- (void)selfClick{
    if (self.model.block) {
        self.model.block(self.model);
    }
}

- (void)setModel:(MarketBoardCellModel *)model{
    _model = model;
    
    self.label_title.text = model.templateHead;
    self.label_info.text = model.templateContent;
    
    if (model.cellType == MarketBoardCellTypeShow) {
        self.label_status.hidden = NO;
        NSString *icon = @"";
        if (model.templateStatus == MarketBoardStatusSuccess) {
            self.label_status.text = @"审核成功";
            icon = @"messageReview_pass_status";
        }else if (model.templateStatus == MarketBoardStatusNoPass) {
            self.label_status.text = @"审核未通过";
            icon = @"messageReview_NoPass_status";
        }else if (model.templateStatus == MarketBoardStatusReviewing) {
            self.label_status.text = @"审核中";
            icon = @"messageReview_reviewing_status";
        }
        self.imageView_statu.image = UIImageName(icon);
        
        [self.imageView_statu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.label_status);
            make.right.mas_equalTo(self.label_status.mas_left).offset(-2);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
    }else if (model.cellType == MarketBoardCellTypeSelect){
        self.label_status.hidden = YES;
        self.imageView_statu.image = UIImageName(@"board_unSelected");
        self.imageView_statu.highlightedImage = UIImageName(@"board_selected");
        self.imageView_statu.highlighted = model.isSelected;
        
        @weakify(self);
        [RACObserve(model, isSelected) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.imageView_statu.highlighted = model.isSelected;
        }];
        
        [self.imageView_statu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.label_status);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
    }else if (model.cellType == MarketBoardCellTypePublic){
        self.label_status.hidden = YES;
        self.imageView_statu.hidden = YES;

    }
    
    
}

@end
