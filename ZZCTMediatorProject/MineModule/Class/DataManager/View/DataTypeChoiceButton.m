//
//  DataTypeChoiceButton.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataTypeChoiceButton.h"

@implementation DataTypeChoiceButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.center = CGPointMake(self.width*0.5-10, self.height*0.5);
    self.imageView.centerY = self.titleLabel.centerY;
    self.imageView.left = self.titleLabel.right+5;
    
}


@end
