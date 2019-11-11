//
//  MessageSendQuestionView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageSendQuestionView.h"

@implementation MessageSendQuestionModel

@end

@implementation MessageSendQuestionCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"" textColor:rgb(152,152,152)];
    label_phone.numberOfLines = 0;
    
    UILabel *label_index = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"" textColor:LZWhiteColor];
    label_index.backgroundColor = rgb(255,81,0);
    label_index.textAlignment = NSTextAlignmentCenter;
    
    _label_title = label_name;
    _label_vaule = label_phone;
    _label_index = label_index;
    
    [self addSubview:label_name];
    [self addSubview:label_phone];
    [self addSubview:label_index];
    
    [label_index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_index.mas_right).offset(5);
        make.centerY.mas_equalTo(label_index);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom).offset(12);
        make.right.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(20);
        make.bottom.mas_equalTo(-15);
    }];
    
    label_index.lz_setView.lz_cornerRadius(8);
}

- (void)setModel:(MessageSendQuestionModel *)model{
    _model = model;
    
    _label_title.text = model.title;
    _label_vaule.text = model.info;
    _label_index.text = [NSString stringWithFormat:@"%ld",model.index];
    
}

@end

@interface MessageSendQuestionView ()

@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation MessageSendQuestionView

- (void)setDataArray:(NSArray<MessageSendQuestionModel *> *)dataArray{
    _dataArray = dataArray;
    
    _cellArray = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i++) {
        MessageSendQuestionCell *cell = [MessageSendQuestionCell new];
        MessageSendQuestionModel *model = dataArray[i];
        model.index = i+1;
        cell.model = model;
        [self addSubview:cell];
        
        if (!self.cellArray.count) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(self);
                make.height.mas_greaterThanOrEqualTo(45);
            }];
        }else {
            MessageSendQuestionCell *lastCell = self.cellArray.lastObject;
            
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self);
                make.height.mas_greaterThanOrEqualTo(45);
                make.top.mas_equalTo(lastCell.mas_bottom);
            }];
        }
        
        if (i == dataArray.count-1){
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self);
            }];
        }else{
            [cell addBottomLine];
            [cell setBottomLineX:15];
        }
        
        [self.cellArray addObject:cell];
    }

}

@end
