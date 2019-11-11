//
//  SPKeyBoardSureButton.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/5/9.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SPKeyBoardSureButton.h"

@implementation SPKeyBoardSureButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.bottom = self.height*0.5;
    self.imageView.centerX = self.width*0.5;
    
    self.titleLabel.top = self.imageView.bottom + 8;
    self.titleLabel.centerX = self.imageView.centerX;

}
@end
