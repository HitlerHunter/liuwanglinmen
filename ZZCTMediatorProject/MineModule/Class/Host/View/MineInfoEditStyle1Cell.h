//
//  MineInfoEditStyle1Cell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineInfoEditStyle1Cell : SDBaseView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *valueLabel;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) BOOL showMoreIcon;

+ (MineInfoEditStyle1Cell *)cellWithTitle:(NSString *)title
                                    vaule:(NSString *)vaule
                                    block:(void (^)(void))block;
+ (MineInfoEditStyle1Cell *)cellWithTitle:(NSString *)title
                                    vaule:(NSString *)vaule
                              placeholder:(NSString *)placeholder
                                    block:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
