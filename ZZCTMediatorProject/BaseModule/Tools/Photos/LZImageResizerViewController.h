//
//  LZImageResizerViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZImageResizerDelegate <NSObject>

- (void)LZImageResizerDidResizeImage:(UIImage *_Nonnull)resizeImage;
- (UIImageView *_Nullable)didTapImageView;
@end
NS_ASSUME_NONNULL_BEGIN

@interface LZImageResizerViewController : SDBaseViewController

@property (nonatomic, weak) id <LZImageResizerDelegate> imageResizerDelegate;

- (instancetype)initWithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
