//
//  LoginOutCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LoginOutCell.h"

@implementation LoginOutCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.centerX = self.width*0.5;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

@end
