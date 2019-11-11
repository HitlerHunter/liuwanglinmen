//
//  LevelUpSelecteCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelUpSelecteCell : SDBaseView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_text;

@property (nonatomic, strong) void (^block)(void);

+ (LevelUpSelecteCell *)cellWithTitle:(NSString *)title
                          placeholder:(NSString *)placeholder
                                block:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
