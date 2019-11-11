//
//  BankCardCell.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/19.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    self.backgroundColor = [UIColor clearColor];
    
    @weakify(self);
    [self.editBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if (self.editBlock) {
            self.editBlock();
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame{
    
//    [super setFrame:frame];
    
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    CGFloat scale = 120.0/333.0;
    CGFloat spacingX = 22;
    
    if (x == spacingX) {
        [super setFrame:frame];
        return;
    }
    
    w = frame.size.width-2*spacingX;
    h = w * scale;
    
    frame = CGRectMake(spacingX, y, w, h);
    
    [super setFrame:frame];
}
@end
