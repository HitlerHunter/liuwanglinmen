//
//  MineInterfaceCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineInterfaceCell : SDBaseView

+ (MineInterfaceCell *)cellWithImage:(NSString *)image title:(NSString *)title block:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
