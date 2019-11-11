//
//  BookTableViewHeaderView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookTableViewHeaderView.h"

@implementation BookTableViewHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.left = 22;
    self.textLabel.centerY = self.contentView.height*0.5;
    
    self.detailTextLabel.right = kScreenWidth - 17;
    self.detailTextLabel.centerY = self.contentView.height*0.5;
}
@end
