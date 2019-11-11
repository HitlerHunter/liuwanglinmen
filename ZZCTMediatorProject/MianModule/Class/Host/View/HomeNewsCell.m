//
//  HomeNewsCell.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/26.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "HomeNewsCell.h"

@implementation HomeNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self addBottomLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
