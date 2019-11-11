//
//  LZTableViewTop.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "LZTableViewTop.h"

@interface LZTableViewTop ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *topImageView;
@end

@implementation LZTableViewTop

+ (LZTableViewTop *)topViewWithScrollView:(UIScrollView *)scrollView image:(UIImage *)image{
    LZTableViewTop * topView = [LZTableViewTop new];
    topView.scrollView = scrollView;
    [topView addTopImageViewWithImage:image];
    return topView;
}

- (void)addTopImageViewWithImage:(UIImage *)image{
    
    if (_hasAddTop) {
        return;
    }
    
    _hasAddTop = YES;
    
    self.topImageView.image = image;
    [self.scrollView addSubview:self.topImageView];
    
    CGFloat imageW = self.scrollView.mj_w;
    CGFloat imageH = imageW * image.size.height/image.size.width;
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, imageH));
        make.top.mas_equalTo(self.scrollView).mas_offset(-imageH);
        make.left.mas_equalTo(self.scrollView);
    }];
    
    CGFloat firstOffsetY = self.scrollView.mj_offsetY;
    
    @weakify(self);
    [[RACObserve(self.scrollView, contentOffset) takeUntil:self.scrollView.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        CGFloat offsetY = self.scrollView.mj_offsetY;
        
        if (offsetY >= imageH) {
            
        }else if (offsetY < - imageH + firstOffsetY){
            
            [self.scrollView setContentOffset:CGPointMake(0, -imageH + firstOffsetY) animated:NO];
            self.scrollView.bounces = NO;
            self.scrollView.bounces = YES;
            
        }
        
    } completed:^{
        
    }];
    
  
}



//  懒加载,
- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _topImageView;
}

@end
