//
//  YasicClipPage.h
//  DynamicClipImage
//
//  Created by yasic on 2017/11/29.
//  Copyright © 2017年 yasic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YasicClipPage;
@protocol YasicClipPageDelegate <NSObject>

- (void)YasicClipPage:(YasicClipPage *)page oldImage:(UIImage *)oldImage newImage:(UIImage *)newImage;

@end
@interface YasicClipPage : UIViewController

@property (nonatomic, weak) id <YasicClipPageDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image;
@end
