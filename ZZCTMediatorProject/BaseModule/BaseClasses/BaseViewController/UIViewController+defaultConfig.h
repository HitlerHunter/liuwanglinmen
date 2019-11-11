//
//  UIViewController+defaultConfig.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/11.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (defaultConfig)
@property (nonatomic, assign, readonly) CGFloat base_statusbarHeight;
@property (nonatomic, assign, readonly) CGFloat base_navigationbarHeight;
@property (nonatomic, assign, readonly) CGFloat base_tabbarHeight;
@end

NS_ASSUME_NONNULL_END
