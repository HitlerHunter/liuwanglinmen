//
//  LZImagesView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZImagesView.h"

@interface LZImagesView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation LZImagesView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id <LZImagesViewDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:tap];
        
        [self addSubview:self.imageView];
        
        _autoScrollTimeInterval = 7.0;
        _autoChangeFrame = NO;
        _delegate = delegate;
        
    }
    return self;
}

- (void)imageViewClick{
    
    if ([self.delegate respondsToSelector:@selector(lz_imagesView:didSelectItemAtIndex:)]) {
        [self.delegate lz_imagesView:self didSelectItemAtIndex:_currentIndex];
    }
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    _totalItemsCount = imageArray.count;
    _currentIndex = 0;
    
    if (imageArray.count) {    
        [self scrollToIndex:0];
        [self setupTimer];
    }else{
        [self invalidateTimer];
    }
}

- (void)setupTimer
{
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    _currentIndex = (_currentIndex+1)%_totalItemsCount;
    [self scrollToIndex:_currentIndex];
}

- (void)scrollToIndex:(NSInteger)index
{
    id image = self.imageArray[index];
    if (image) {
        if ([image isKindOfClass:[UIImage class]]) {
            [self showImage:image];
        }else if ([image isKindOfClass:[NSString class]]){
            if ([image hasPrefix:@"http"]) {
                [self uploadImageWithURL:image];
            }else{
                [self showImage:UIImageName(image)];
            }
        }
    }
}

- (void)uploadImageWithURL:(NSString *)url{
    UIImage *placeholderImage = nil;
    if (self.imageView.image) {
        placeholderImage = self.imageView.image;
    }
    
    [self.imageView sd_setImageWithURL:TLURL(url) placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self showImage:image];
    }];
    
}

- (void)showImage:(UIImage *)image{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
        // 使用@"suck"动画, 该动画与动画方向无关
    transition.type = @"fade";
    [self.imageView.layer addAnimation:transition forKey:@"animation"];
    
    self.imageView.image = image;
    
    if (_autoChangeFrame) {
        
        CGFloat scale = image.size.height / image.size.width;
        
        [UIView animateWithDuration:0.5f animations:^{
            self.height = self.width*scale;
            self.imageView.height = self.height;
        } completion:^(BOOL finished) {
            if (finished && [self.delegate respondsToSelector:@selector(lz_imagesView:didChangeFrame:)]) {
                [self.delegate lz_imagesView:self didChangeFrame:self.frame];
            }
        }];
    }
    
    
    
}

@end
