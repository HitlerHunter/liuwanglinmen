//
//  LZNoDataView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZNoDataView : SDBaseView

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) CGFloat offsetY;
@end

NS_ASSUME_NONNULL_END
