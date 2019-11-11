//
//  HomeTopToolView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTopToolView : SDBaseView

@property (nonatomic, strong) void (^clickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
