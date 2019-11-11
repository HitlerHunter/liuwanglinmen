//
//  HomeCellView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCellView : SDBaseView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) void (^clickBlock)(void);
@end

NS_ASSUME_NONNULL_END
