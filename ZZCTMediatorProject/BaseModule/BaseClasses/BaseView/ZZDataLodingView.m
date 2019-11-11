//
//  ZZDataLodingView.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/10/13.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "ZZDataLodingView.h"

@interface ZZDataLodingView ()
@property (nonatomic, strong) UIActivityIndicatorView *ActivityIndicatorView;
@end

@implementation ZZDataLodingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.ActivityIndicatorView];
        self.backgroundColor = UIColorHex(0xEBEBEB);
        self.ActivityIndicatorView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }
    return self;
}

- (void)loading{
    [self.ActivityIndicatorView startAnimating];
}

- (void)stopLoding{
    [self.ActivityIndicatorView stopAnimating];
}

- (UIActivityIndicatorView *)ActivityIndicatorView{
    if (!_ActivityIndicatorView) {
        _ActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _ActivityIndicatorView.center = CGPointMake(self.width*0.5, self.height*0.5);
        _ActivityIndicatorView.color = [UIColor grayColor];
    }
    return _ActivityIndicatorView;
}
@end
