//
//  SureOrderToolView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SureOrderToolView : SDBaseView

@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) void (^submitBlock)(void);
@end

NS_ASSUME_NONNULL_END
