//
//  StoreSelectCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/10/22.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "StoreSelectCell.h"

@implementation StoreSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.textLabel.centerX = self.width/2;
    self.textLabel.frame = self.contentView.bounds;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.numberOfLines = 2;
    self.textLabel.adjustsFontSizeToFitWidth = YES;
}
@end
