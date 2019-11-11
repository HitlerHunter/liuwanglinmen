//
//  LevelUpInputCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelUpInputCell : SDBaseView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UITextField *textField;

+ (LevelUpInputCell *)cellWithTitle:(NSString *)title
                        placeholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
