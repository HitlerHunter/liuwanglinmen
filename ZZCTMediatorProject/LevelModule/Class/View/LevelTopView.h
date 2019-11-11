//
//  LevelTopView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelTopView : SDBaseView

@property (nonatomic, strong) void (^levelClickBlock)(NSInteger index);
- (void)toSelectInde:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
