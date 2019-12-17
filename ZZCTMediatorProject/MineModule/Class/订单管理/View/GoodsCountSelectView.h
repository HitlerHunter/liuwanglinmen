//
//  GoodsCountSelectView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/13.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsCountSelectView : SDBaseView
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger minCount;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, strong) void (^countDidChangeBlock)(NSUInteger count);

@end

NS_ASSUME_NONNULL_END
