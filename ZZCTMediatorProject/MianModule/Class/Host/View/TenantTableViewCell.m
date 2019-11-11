//
//  TenantTableViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "TenantTableViewCell.h"

@implementation TenantTableViewCell

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
    
    self.textLabel.center = CGPointMake(self.width/2, self.height/2);
}
@end
