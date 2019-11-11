//
//  NinaPagerButton.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/24.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "NinaPagerButton.h"

@interface NinaPagerButton ()
@property (nonatomic, strong) UILabel *unreadLabel;
@end

@implementation NinaPagerButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _unreadLabel = [UILabel labelWithFontSize:9 textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
        _unreadLabel.adjustsFontSizeToFitWidth = YES;
        _unreadLabel.backgroundColor = LZRedColor_1;
        _unreadLabel.frame = CGRectMake(0, 0, 15, 15);
        _unreadLabel.lz_setView.lz_cornerRadius(_unreadLabel.height*0.5);
        _unreadLabel.hidden = YES;
        [self addSubview:_unreadLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _unreadLabel.center = CGPointMake(self.titleLabel.right+_unreadLabel.width*0.5, self.titleLabel.top);
}

- (void)setUnreadCount:(NSInteger)unreadCount{
    _unreadCount = unreadCount;
    
    NSLog(@"未读: %ld",(long)unreadCount);
    if (unreadCount == 0) {
        _unreadLabel.hidden = YES;
        return;
    }else if (unreadCount < 99){
        _unreadLabel.width = 15;
    }else if (unreadCount > 99){
        _unreadLabel.width = 20;
    }else if (unreadCount >= 999){
        unreadCount = 999;
        _unreadLabel.width = 20;
    }
    
    _unreadLabel.hidden = NO;
    _unreadLabel.text = [NSString stringWithFormat:@"%ld",(long)unreadCount];
}

- (void)readAll{
    self.unreadCount = 0;
}
@end
