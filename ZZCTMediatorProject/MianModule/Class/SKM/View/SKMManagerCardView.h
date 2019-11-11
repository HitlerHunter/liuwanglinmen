//
//  SKMManagerCardView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKMIconView : SDBaseView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;

@end

@interface SKMManagerCardView : SDBaseView

@property (nonatomic, strong) UILabel *label_info;
@property (nonatomic, strong) UIImageView *codeImageView;

- (instancetype)initWithWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
