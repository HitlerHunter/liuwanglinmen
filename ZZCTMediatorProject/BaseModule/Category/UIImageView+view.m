//
//  UIImageView+view.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/12.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "UIImageView+view.h"

@implementation UIImageView (view)


+ (UIImageView *)view{
    return [[UIImageView alloc] init];
}

+ (UIImageView *)viewWithImage:(UIImage *)image{
    UIImageView *imageView = [self view];
    imageView.image = image;
    return imageView;
}


@end
