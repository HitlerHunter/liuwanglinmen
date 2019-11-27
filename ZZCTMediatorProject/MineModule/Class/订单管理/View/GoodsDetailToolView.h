//
//  GoodsDetailToolView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailToolView : SDBaseView

@property (nonatomic, strong) void (^buyBlock)(void);

@end

NS_ASSUME_NONNULL_END
