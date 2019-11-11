//
//  LZSearchBarView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/1.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZSearchBarView : SDBaseView

@property (nonatomic, strong) void (^didReturnBlock)(NSString *str);
@end

NS_ASSUME_NONNULL_END
