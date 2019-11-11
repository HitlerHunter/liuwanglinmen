//
//  LZImageResizerViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZImageResizerViewController.h"
#import <JPImageresizerView.h>
@interface LZImageResizerViewController ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *tapImageView;
@property (nonatomic, weak) JPImageresizerView *imageresizerView;

//@property (nonatomic, strong) JPImageresizerConfigure *configure;
@end

@implementation LZImageResizerViewController

- (instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"裁剪图片";
    [self initResizerView];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"确定" font:nil color:nil block:^{
        @strongify(self);
        [self resize];
    }];
    
    UIButton *resetSizeBtn = [UIButton new];
    resetSizeBtn.titleLabel.font = kfont(14);
    [resetSizeBtn setTitle:@"自定义比例" forState:UIControlStateNormal];
    [resetSizeBtn setTitleColor:LZOrangeColor forState:UIControlStateNormal];
    
    resetSizeBtn.lz_setView.lz_cornerRadius(15).lz_border(0.5, LZOrangeColor);
    
    [self.view addSubview:resetSizeBtn];
    [self.view bringSubviewToFront:resetSizeBtn];
    
    [resetSizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-38);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [resetSizeBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        self.imageresizerView.resizeWHScale = 0;
    }];
    
    
}

- (void)initResizerView{
    
        //.jp_resizeImage([UIImage imageNamed:@"Lotus.jpg"])
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(LZApp.shareInstance.app_navigationBarHeight+30, 0, 0, 0);
    
    JPImageresizerConfigure *configure3 = [JPImageresizerConfigure blurMaskTypeConfigureWithResizeImage:self.image isLight:YES make:^(JPImageresizerConfigure *configure) {
        configure.jp_contentInsets(contentInsets)
        .jp_strokeColor(LZOrangeColor)
        .jp_frameType(JPClassicFrameType)
        .jp_animationCurve(JPAnimationCurveEaseOut)
        .jp_isClockwiseRotation(YES);
        
    }];
    
    self.view.backgroundColor = configure3.bgColor;
    
        //    self.recoveryBtn.enabled = NO;
    
    __weak typeof(self) wSelf = self;
    JPImageresizerView *imageresizerView = [JPImageresizerView imageresizerViewWithConfigure:configure3 imageresizerIsCanRecovery:^(BOOL isCanRecovery) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
            // 当不需要重置设置按钮不可点
            //        sSelf.recoveryBtn.enabled = isCanRecovery;
    } imageresizerIsPrepareToScale:^(BOOL isPrepareToScale) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
            // 当预备缩放设置按钮不可点，结束后可点击
            //        BOOL enabled = !isPrepareToScale;
            //        sSelf.rotateBtn.enabled = enabled;
            //        sSelf.resizeBtn.enabled = enabled;
            //        sSelf.horMirrorBtn.enabled = enabled;
            //        sSelf.verMirrorBtn.enabled = enabled;
    }];
    [self.view insertSubview:imageresizerView atIndex:0];
    self.imageresizerView = imageresizerView;
    
//    self.imageresizerView.resizeWHScale = 0;
    
    if (self.tapImageView) {
        self.imageresizerView.resizeWHScale = self.tapImageView.width/self.tapImageView.height;
    }else{
        self.imageresizerView.resizeWHScale = 0;
    }
}

- (void)resize{
//    self.recoveryBtn.enabled = NO;
    
    __weak typeof(self) weakSelf = self;
    
        // 1.默认以imageView的宽度为参照宽度进行裁剪
    [self.imageresizerView imageresizerWithComplete:^(UIImage *resizeImage) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        if (!resizeImage) {
            NSLog(@"没有裁剪图片");
            [self showMessage:@"裁剪失败！"];
            return;
        }
        
        if (strongSelf.imageResizerDelegate && [strongSelf.imageResizerDelegate respondsToSelector:@selector(LZImageResizerDidResizeImage:)]) {
            [strongSelf.imageResizerDelegate LZImageResizerDidResizeImage:resizeImage];
        }
        
        [strongSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    
    
        // 2.自定义参照宽度进行裁剪（例如按屏幕宽度）
        //    [self.imageresizerView imageresizerWithComplete:^(UIImage *resizeImage) {
        //        // 裁剪完成，resizeImage为裁剪后的图片
        //        // 注意循环引用
        //    } referenceWidth:[UIScreen mainScreen].bounds.size.width];
    
        // 3.以原图尺寸进行裁剪
        //    [self.imageresizerView originImageresizerWithComplete:^(UIImage *resizeImage) {
        //        // 裁剪完成，resizeImage为裁剪后的图片
        //        // 注意循环引用
        //    }];
}

- (UIImageView *)tapImageView{
    if (self.imageResizerDelegate && [self.imageResizerDelegate respondsToSelector:@selector(didTapImageView)]) {
        return [self.imageResizerDelegate didTapImageView];
    }
    
    return nil;
}
@end
