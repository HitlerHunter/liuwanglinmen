//
//  MineDelegateTypeView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/15.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineDelegateTypeView : SDBaseView

@property (nonatomic, strong) void (^clickBlock)(NSInteger index);

- (void)showWithNoAnimation;
- (void)showAnimationWithSuperView:(UIView *)superView;
- (void)dismissAnimation;

- (void)setTitleArray:(NSArray *)titleArray;
@end

NS_ASSUME_NONNULL_END
