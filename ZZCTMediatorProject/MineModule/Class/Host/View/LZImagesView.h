//
//  LZImagesView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LZImagesView;
@protocol LZImagesViewDelegate <NSObject>

@optional
/** 点击图片回调 */
- (void)lz_imagesView:(LZImagesView *)imagesView didSelectItemAtIndex:(NSInteger)index;
/** 图片滚动回调 */
- (void)lz_imagesView:(LZImagesView *)imagesView didScrollToIndex:(NSInteger)index;
/** 图片滚动回调 */
- (void)lz_imagesView:(LZImagesView *)imagesView didChangeFrame:(CGRect)frame;
@end

@interface LZImagesView : UIView

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, weak) id <LZImagesViewDelegate> delegate;
/** 自动根据图片改变大小,默认 NO */
@property (nonatomic, assign) BOOL autoChangeFrame;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id <LZImagesViewDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
