//
//  BillRepayCell.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/18.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "BillRepayCell.h"

@implementation BillRepayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.status.lz_setView.lz_cornerRadius(4);
    
    [self addBottomLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
